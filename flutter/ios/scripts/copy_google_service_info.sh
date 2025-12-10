#!/bin/bash

# Copy GoogleService-Info.plist based on build configuration
# This script is used as a Build Phase in Xcode

# Determine which plist to use based on configuration
# Default to PROD unless the configuration explicitly contains "-stg".
PLIST_SRC=""
if [[ "${CONFIGURATION}" == *"-stg"* ]]; then
    PLIST_SRC="${PROJECT_DIR}/Runner/GoogleService-Info-stg.plist"
    echo "Using STG GoogleService-Info.plist"
else
    PLIST_SRC="${PROJECT_DIR}/Runner/GoogleService-Info-prod.plist"
    echo "Using PROD GoogleService-Info.plist"
fi

PLIST_DEST="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

# Check if source file exists
if [ -f "$PLIST_SRC" ]; then
    cp "$PLIST_SRC" "$PLIST_DEST"
    echo "Copied: $PLIST_SRC -> $PLIST_DEST"
else
    echo "Error: $PLIST_SRC not found"
    echo ""
    echo "For STG: GoogleService-Info-stg.plist should be in the repository"
    echo "For PROD: Download GoogleService-Info-prod.plist from Firebase Console"
    exit 1
fi
