status=$(ps uax | grep alphasersver | grep -v grep)

if [ "$status" ]; then
echo "oje";
else
echo "no";
fi
