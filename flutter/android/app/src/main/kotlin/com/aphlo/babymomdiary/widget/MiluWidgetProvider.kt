package com.aphlo.babymomdiary.widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import com.aphlo.babymomdiary.R
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.*
import android.app.PendingIntent
import android.content.Intent
import android.net.Uri

open class MiluWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.milu_widget_medium)

            // Load widget data
            val widgetDataJson = widgetData.getString("widget_data", null)
            val settingsJson = widgetData.getString("widget_settings", null)

            if (widgetDataJson != null) {
                try {
                    val data = JSONObject(widgetDataJson)
                    val settings = if (settingsJson != null) JSONObject(settingsJson) else JSONObject()

                    // Get selected child
                    val selectedChildId = data.optString("selectedChildId", "")
                    val children = data.optJSONArray("children") ?: org.json.JSONArray()

                    var selectedChild: JSONObject? = null
                    for (i in 0 until children.length()) {
                        val child = children.getJSONObject(i)
                        if (child.getString("id") == selectedChildId) {
                            selectedChild = child
                            break
                        }
                    }
                    if (selectedChild == null && children.length() > 0) {
                        selectedChild = children.getJSONObject(0)
                    }

                    // Set child info
                    if (selectedChild != null) {
                        val name = selectedChild.getString("name")
                        val birthday = selectedChild.getString("birthday")
                        views.setTextViewText(R.id.child_name, name)
                        views.setTextViewText(R.id.child_age, formatAge(birthday))
                    } else {
                        views.setTextViewText(R.id.child_name, "子ども未登録")
                        views.setTextViewText(R.id.child_age, "")
                    }

                    // Get recent records
                    val recentRecords = data.optJSONObject("recentRecords")
                    val childRecords = if (selectedChild != null) {
                        recentRecords?.optJSONArray(selectedChild.getString("id"))
                    } else null

                    // Get display record types from settings
                    val mediumSettings = settings.optJSONObject("mediumWidget")
                    val displayTypes = mediumSettings?.optJSONArray("displayRecordTypes")
                        ?: org.json.JSONArray().apply {
                            put("breast")  // breastRight/breastLeftをまとめて扱う
                            put("formula")
                            put("pee")
                        }

                    // Set record cards
                    for (i in 0 until minOf(displayTypes.length(), 3)) {
                        val recordType = displayTypes.getString(i)
                        val record = findRecordByTypeOrCategory(childRecords, recordType)

                        val (emojiId, labelId, timeId, agoId) = getRecordViewIds(i)

                        if (record != null) {
                            val actualType = record.getString("type")
                            views.setTextViewText(emojiId, getRecordEmoji(actualType))
                            views.setTextViewText(labelId, getRecordLabel(actualType))

                            val atDate = parseIsoDate(record.getString("at"))
                            if (atDate != null) {
                                views.setTextViewText(timeId, formatTime(atDate))
                                views.setTextViewText(agoId, formatTimeAgo(atDate))
                            } else {
                                views.setTextViewText(timeId, "--")
                                views.setTextViewText(agoId, "")
                            }
                        } else {
                            views.setTextViewText(emojiId, getRecordEmoji(recordType))
                            views.setTextViewText(labelId, getRecordLabel(recordType))
                            views.setTextViewText(timeId, "--")
                            views.setTextViewText(agoId, "")
                        }
                    }

                    // Set quick action buttons
                    val quickActionTypes = mediumSettings?.optJSONArray("quickActionTypes")
                        ?: org.json.JSONArray().apply {
                            put("breastRight")
                            put("formula")
                            put("pee")
                            put("poop")
                            put("temperature")
                        }

                    for (i in 0 until minOf(quickActionTypes.length(), 5)) {
                        val actionType = quickActionTypes.getString(i)
                        val buttonId = getQuickActionButtonId(i)

                        views.setTextViewText(buttonId, getRecordEmoji(actionType))

                        // Set click intent for deep link
                        val intent = Intent(Intent.ACTION_VIEW, Uri.parse("milu://record/add?type=$actionType"))
                        val pendingIntent = PendingIntent.getActivity(
                            context,
                            i,
                            intent,
                            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                        )
                        views.setOnClickPendingIntent(buttonId, pendingIntent)
                    }

                } catch (e: Exception) {
                    e.printStackTrace()
                    setEmptyState(views)
                }
            } else {
                setEmptyState(views)
            }

            // Set click intent for whole widget
            val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun setEmptyState(views: RemoteViews) {
        views.setTextViewText(R.id.child_name, "子ども未登録")
        views.setTextViewText(R.id.child_age, "")
    }

    private fun findRecordByType(records: org.json.JSONArray?, type: String): JSONObject? {
        if (records == null) return null
        for (i in 0 until records.length()) {
            val record = records.getJSONObject(i)
            if (record.getString("type") == type) {
                return record
            }
        }
        return null
    }

    /// カテゴリまたはタイプで記録を検索
    /// "breast" の場合は breastRight/breastLeft の最新を返す
    /// 未来の記録は除外する
    private fun findRecordByTypeOrCategory(records: org.json.JSONArray?, typeOrCategory: String): JSONObject? {
        if (records == null) return null

        // カテゴリの場合、該当するタイプのリストを取得
        val targetTypes = when (typeOrCategory) {
            "breast" -> listOf("breastRight", "breastLeft")
            else -> listOf(typeOrCategory)
        }

        val now = Date()
        var latestRecord: JSONObject? = null
        var latestDate: Date? = null

        for (i in 0 until records.length()) {
            val record = records.getJSONObject(i)
            val recordType = record.getString("type")

            if (targetTypes.contains(recordType)) {
                val atDate = parseIsoDate(record.getString("at"))
                if (atDate != null) {
                    // 未来の記録は除外
                    if (atDate.after(now)) {
                        continue
                    }
                    if (latestDate == null || atDate.after(latestDate)) {
                        latestDate = atDate
                        latestRecord = record
                    }
                }
            }
        }

        return latestRecord
    }

    private fun getRecordViewIds(index: Int): Quadruple {
        return when (index) {
            0 -> Quadruple(R.id.record1_emoji, R.id.record1_label, R.id.record1_time, R.id.record1_ago)
            1 -> Quadruple(R.id.record2_emoji, R.id.record2_label, R.id.record2_time, R.id.record2_ago)
            else -> Quadruple(R.id.record3_emoji, R.id.record3_label, R.id.record3_time, R.id.record3_ago)
        }
    }

    private fun getQuickActionButtonId(index: Int): Int {
        return when (index) {
            0 -> R.id.action1
            1 -> R.id.action2
            2 -> R.id.action3
            3 -> R.id.action4
            else -> R.id.action5
        }
    }

    private fun getRecordEmoji(type: String): String {
        return when (type) {
            "breast", "breastRight", "breastLeft" -> "🤱"
            "formula" -> "🍼"
            "pump" -> "🥛"
            "pee" -> "💧"
            "poop" -> "💩"
            "temperature" -> "🌡️"
            "other" -> "📝"
            else -> "📝"
        }
    }

    private fun getRecordLabel(type: String): String {
        return when (type) {
            "breast" -> "授乳"  // カテゴリ用（記録がない場合）
            "breastRight" -> "授乳(右)"
            "breastLeft" -> "授乳(左)"
            "formula" -> "ミルク"
            "pump" -> "搾母乳"
            "pee" -> "尿"
            "poop" -> "便"
            "temperature" -> "体温"
            "other" -> "その他"
            else -> type
        }
    }

    private fun formatAge(birthday: String): String {
        try {
            val formatter = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
            val birthDate = formatter.parse(birthday) ?: return ""
            val now = Calendar.getInstance()
            val birth = Calendar.getInstance().apply { time = birthDate }

            var years = now.get(Calendar.YEAR) - birth.get(Calendar.YEAR)
            var months = now.get(Calendar.MONTH) - birth.get(Calendar.MONTH)
            var days = now.get(Calendar.DAY_OF_MONTH) - birth.get(Calendar.DAY_OF_MONTH)

            if (days < 0) {
                months--
                val prevMonth = Calendar.getInstance().apply {
                    time = now.time
                    add(Calendar.MONTH, -1)
                }
                days += prevMonth.getActualMaximum(Calendar.DAY_OF_MONTH)
            }
            if (months < 0) {
                years--
                months += 12
            }

            return when {
                years > 0 -> "${years}歳${months}ヶ月"
                months > 0 -> "${months}ヶ月${days}日目"
                else -> "${days}日目"
            }
        } catch (e: Exception) {
            return ""
        }
    }

    private fun parseIsoDate(isoString: String): Date? {
        // 複数の日付形式を試行
        val formats = listOf(
            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",  // 2025-12-05T20:56:00.000Z (UTC)
            "yyyy-MM-dd'T'HH:mm:ss.SSS",      // 2025-12-05T20:56:00.000 (ローカル)
            "yyyy-MM-dd'T'HH:mm:ss'Z'",       // 2025-12-05T20:56:00Z (UTC)
            "yyyy-MM-dd'T'HH:mm:ss"           // 2025-12-05T20:56:00 (ローカル)
        )

        for (format in formats) {
            try {
                val formatter = SimpleDateFormat(format, Locale.getDefault())
                // 'Z'で終わる形式のみUTCとして解釈、それ以外はローカル時間
                if (format.endsWith("'Z'")) {
                    formatter.timeZone = TimeZone.getTimeZone("UTC")
                }
                // else: ローカルタイムゾーンを使用（デフォルト）
                return formatter.parse(isoString)
            } catch (e: Exception) {
                // 次のフォーマットを試す
            }
        }
        return null
    }

    private fun formatTime(date: Date): String {
        val formatter = SimpleDateFormat("HH:mm", Locale.getDefault())
        return formatter.format(date)
    }

    private fun formatTimeAgo(date: Date): String {
        val now = Date()
        val diffMinutes = ((now.time - date.time) / (1000 * 60)).toInt()
        val diffHours = diffMinutes / 60

        return when {
            diffMinutes < 1 -> "たった今"
            diffMinutes < 60 -> "${diffMinutes}分前"
            diffHours < 24 -> "${diffHours}時間前"
            else -> "${diffHours / 24}日前"
        }
    }

    data class Quadruple(val first: Int, val second: Int, val third: Int, val fourth: Int)
}
