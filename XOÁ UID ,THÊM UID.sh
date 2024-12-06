#!/bin/bash

# Màu sắc cho các dòng in
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

# Đường dẫn tới thư mục chứa các file cần xử lý
DIRECTORY='/storage/emulated/0/Download/Telegram/funny1/30/'

# Kiểm tra thư mục có tồn tại không
if [[ ! -d "$DIRECTORY" ]]; then
    echo -e "${RED}Thư mục không tồn tại. Thoát chương trình.${RESET}"
    exit 1
fi

# Hiển thị menu lựa chọn
echo -e "${YELLOW}Chọn hành động:${RESET}"
echo "1. Thêm UID"
echo "2. Xóa UID"
printf "Nhập lựa chọn (1 hoặc 2): " 
read ACTION_CHOICE

# Xác định hành động dựa trên lựa chọn
if [[ "$ACTION_CHOICE" == "1" ]]; then
    ACTION="add"
    echo -e "${BLUE}Bạn đã chọn: Thêm UID${RESET}"
elif [[ "$ACTION_CHOICE" == "2" ]]; then
    ACTION="remove"
    echo -e "${BLUE}Bạn đã chọn: Xóa UID${RESET}"
else
    echo -e "${RED}Lựa chọn không hợp lệ. Thoát chương trình.${RESET}"
    exit 1
fi

# Nhập UID cần thêm/xóa
printf "${CYAN}Nhập UID cần xử lý: ${RESET}"
read UID_TO_PROCESS
COUNT=0
# Duyệt qua tất cả các file trong thư mục
for FILE in "$DIRECTORY"/*; do
    # Kiểm tra nếu là file
    if [[ -f "$FILE" ]]; then
        #echo -e "${GREEN}Đang xử lý file: $FILE${RESET}"
        
        # Đọc nội dung hiện tại của file
        CONTENT=$(cat "$FILE")

        if [[ "$ACTION" == "add" ]]; then
            # Thêm UID nếu chưa tồn tại
            if [[ "$CONTENT" != *"$UID_TO_PROCESS"* ]]; then
				if echo "$CONTENT" | grep -q '"trade_list":\[\]'; then
					UPDATED_CONTENT=$(echo "$CONTENT" | sed -E "s/\"trade_list\":\[\]/\"trade_list\":[\"$UID_TO_PROCESS\"]/")
				else
					UPDATED_CONTENT=$(echo "$CONTENT" | sed -E "s/\"trade_list\":\[(.*)\]/\"trade_list\":[\1,\"$UID_TO_PROCESS\"]/")
				fi
                echo "$UPDATED_CONTENT" > "$FILE"
                echo -e "${GREEN}Đã thêm UID: $UID_TO_PROCESS vào $FILE${RESET}"
                ((COUNT++))
            else
                echo -e "${YELLOW}UID đã tồn tại trong file: $FILE${RESET}"
            fi
        elif [[ "$ACTION" == "remove" ]]; then
            # Xóa UID nếu tồn tại
            UPDATED_CONTENT=$(echo "$CONTENT" | sed -E "s/\"$UID_TO_PROCESS\",?|,?\"$UID_TO_PROCESS\"//g")
            echo "$UPDATED_CONTENT" > "$FILE"
            echo -e "${GREEN}Đã xóa UID: $UID_TO_PROCESS khỏi $FILE${RESET}"
            ((COUNT++))
        fi
    else
        echo -e "${YELLOW}$FILE không phải là file hợp lệ, bỏ qua.${RESET}"
    fi
done

echo -e "${CYAN}Tổng số file đã xóa hoặc thêm thành công: \"$COUNT\".${RESET}"