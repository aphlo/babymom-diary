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

open class MiluWidgetSmallProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.milu_widget_small)

            // Load widget data
            val widgetDataJson = widgetData.getString("widget_data", null)

            // Load widget settings
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

                    // Get display record type from settings (first item)
                    val mediumSettings = settings.optJSONObject("mediumWidget")
                    val displayTypes = mediumSettings?.optJSONArray("displayRecordTypes")
                    val primaryDisplayType = if (displayTypes != null && displayTypes.length() > 0) {
                        displayTypes.getString(0)
                    } else {
                        "breast" // デフォルト
                    }

                    // Get the latest record for the primary display type
                    val latestRecord = findRecordByTypeOrCategory(childRecords, primaryDisplayType)
                    if (latestRecord != null) {
                        val recordType = latestRecord.getString("type")
                        val atDate = parseIsoDate(latestRecord.getString("at"))

                        views.setTextViewText(R.id.record_emoji, getRecordEmoji(recordType))
                        views.setTextViewText(R.id.record_label, getRecordLabel(recordType))

                        if (atDate != null) {
                            views.setTextViewText(R.id.record_time, formatTime(atDate))
                            views.setTextViewText(R.id.record_ago, formatTimeAgo(atDate))
                        } else {
                            views.setTextViewText(R.id.record_time, "--:--")
                            views.setTextViewText(R.id.record_ago, "")
                        }
                    } else {
                        views.setTextViewText(R.id.record_emoji, getRecordEmoji(primaryDisplayType))
                        views.setTextViewText(R.id.record_label, getRecordLabel(primaryDisplayType))
                        views.setTextViewText(R.id.record_time, "--")
                        views.setTextViewText(R.id.record_ago, "")
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
        views.setTextViewText(R.id.record_emoji, "📝")
        views.setTextViewText(R.id.record_label, "記録なし")
        views.setTextViewText(R.id.record_time, "--:--")
        views.setTextViewText(R.id.record_ago, "")
    }

    /// カテゴリまたはタイプで記録を検索
    /// "breast" の場合は breastRight/breastLeft の最新を返す
    /// 未来の記録、および24時間以上前の記録は除外する
    private fun findRecordByTypeOrCategory(records: org.json.JSONArray?, typeOrCategory: String): JSONObject? {
        if (records == null) return null

        // カテゴリの場合、該当するタイプのリストを取得
        // 授乳は breastRight/breastLeft どちらが指定されても両方検索する
        val targetTypes = when (typeOrCategory) {
            "breast", "breastRight", "breastLeft" -> listOf("breastRight", "breastLeft")
            else -> listOf(typeOrCategory)
        }

        val now = Date()
        val twentyFourHoursAgo = Date(now.time - 24 * 60 * 60 * 1000) // 24時間前
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
                    // 24時間以上前の記録は除外
                    if (atDate.before(twentyFourHoursAgo)) {
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
        val remainingMinutes = diffMinutes % 60

        return when {
            diffMinutes < 1 -> "たった今"
            diffMinutes < 60 -> "${diffMinutes}分前"
            diffHours < 24 -> {
                if (remainingMinutes > 0) {
                    "${diffHours}時間${remainingMinutes}分前"
                } else {
                    "${diffHours}時間前"
                }
            }
            else -> "${diffHours / 24}日前"
        }
    }
}
