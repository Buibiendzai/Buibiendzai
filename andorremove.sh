#!/bin/bash

# Màu sắc cho các dòng in
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

# Đường dẫn tới thư mục chứa các file cần xử lý
DIRECTORY='/storage/emulated/0/Download/com.tgc.sky.funny/files/config'

# Kiểm tra thư mục có tồn tại không
if [[ ! -d "$DIRECTORY" ]]; then
    echo -e "${RED}Thư mục không tồn tại. Thoát chương trình.${RESET}"
    exit 1
fi

# Hiển thị menu lựa chọn
echo -e "${YELLOW}Chọn hành động:${RESET}"
echo "1. Thêm UID"
echo "2. Xóa UID"
echo "3. Thêm nhiều UID"
echo "4. Xóa nhiều UID"
printf "Nhập lựa chọn (1, 2, 3 hoặc 4): " 
read ACTION_CHOICE

# Xác định hành động dựa trên lựa chọn
if [[ "$ACTION_CHOICE" == "1" ]]; then
    ACTION="add"
    MODE="single"
    echo -e "${BLUE}Bạn đã chọn: Thêm UID${RESET}"
elif [[ "$ACTION_CHOICE" == "2" ]]; then
    ACTION="remove"
    MODE="single"
    echo -e "${BLUE}Bạn đã chọn: Xóa UID${RESET}"
elif [[ "$ACTION_CHOICE" == "3" ]]; then
    ACTION="add"
    MODE="multi"
    echo -e "${BLUE}Bạn đã chọn: Thêm nhiều UID${RESET}"
elif [[ "$ACTION_CHOICE" == "4" ]]; then
    ACTION="remove"
    MODE="multi"
    echo -e "${BLUE}Bạn đã chọn: Xóa nhiều UID${RESET}"
else
    echo -e "${RED}Lựa chọn không hợp lệ. Thoát chương trình.${RESET}"
    exit 1
fi

# Thu thập danh sách UID cần xử lý
UID_LIST=()
if [[ "$MODE" == "single" ]]; then
    printf "${CYAN}Nhập UID cần xử lý: ${RESET}"
    read UID_INPUT
    UID_LIST=("$UID_INPUT")
elif [[ "$MODE" == "multi" ]]; then
    printf "${CYAN}Bạn muốn xử lý bao nhiêu UID? ${RESET}"
    read UID_COUNT

    if ! echo "$UID_COUNT" | grep -qE '^[0-9]+$' || [ "$UID_COUNT" -le 0 ]; then
        echo -e "${RED}Số lượng không hợp lệ. Thoát chương trình.${RESET}"
        exit 1
    fi

    echo -e "${CYAN}Nhập lần lượt từng UID:${RESET}"
    i=1
    while [ "$i" -le "$UID_COUNT" ]; do
        printf "UID $i: "
        read UID_INPUT
        UID_LIST+=("$UID_INPUT")
        i=$((i + 1))
    done
fi

echo -e "${CYAN}Danh sách UID cần xử lý: ${RESET}${UID_LIST[@]}"
COUNT=0

# Duyệt qua tất cả các file trong thư mục
for FILE in "$DIRECTORY"/*; do
    if [[ -f "$FILE" ]]; then
        CONTENT=$(cat "$FILE")

        for UID_TO_PROCESS in "${UID_LIST[@]}"; do
            if [[ "$ACTION" == "add" ]]; then
                if [[ "$CONTENT" != *"$UID_TO_PROCESS"* ]]; then
                    if echo "$CONTENT" | grep -q '"trade_list":\[\]'; then
                        CONTENT=$(echo "$CONTENT" | sed -E "s/\"trade_list\":\[\]/\"trade_list\":[\"$UID_TO_PROCESS\"]/")
                    else
                        CONTENT=$(echo "$CONTENT" | sed -E "s/\"trade_list\":\[(.*)\]/\"trade_list\":[\1,\"$UID_TO_PROCESS\"]/")
                    fi
                    echo "$CONTENT" > "$FILE"
                    echo -e "${GREEN}Đã thêm UID: $UID_TO_PROCESS vào $FILE${RESET}"
                else
                    echo -e "${YELLOW}UID đã tồn tại trong file: $FILE${RESET}"
                fi
            elif [[ "$ACTION" == "remove" ]]; then
                CONTENT=$(echo "$CONTENT" | sed -E "s/\"$UID_TO_PROCESS\",?|,?\"$UID_TO_PROCESS\"//g")
                echo "$CONTENT" > "$FILE"
                echo -e "${GREEN}Đã xóa UID: $UID_TO_PROCESS khỏi $FILE${RESET}"
            fi
        done
    else
        echo -e "${YELLOW}$FILE không phải là file hợp lệ, bỏ qua.${RESET}"
    fi
done

echo -e "${CYAN}Tổng số file đã xử lý thành công: \"$COUNT\".${RESET}"
