$git_address = "https://github.com/tensorflow/tensorflow.git" #git repo的複製地址
$version_num = 25 							#總共要收集的版本數量
$gap = 3000									#每個版本間要相差多少版本
git clone $git_address
$folder = Get-ChildItem -Path . -Directory			#抓取git repo名稱，資料夾中如果有其他檔案可能會造成抓錯
for ($i = 1; $i -le $version_num; $i++){
	Copy-Item "./$folder" -Destination "./$i" -Recurse
	cd $i
	$temp = $i * $gap
	git checkout head~$temp
	Remove-Item "./.git" -Recurse -Force			#刪除.git檔案
	cd ..
}
