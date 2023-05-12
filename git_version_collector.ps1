# git rev-list --count <revision> 查詢git commit總量
$git_address = "https://github.com/tensorflow/tensorflow.git" #git repo的複製地址
$version_num = 25 							#總共要收集的版本數量
$gap = 3000									#每個版本間要相差多少版本
$folder = "tensorflow"
git clone $git_address
$tar_folder = $folder + "_tar"
New-Item -Path . -Name $tar_folder -ItemType "directory"
for ($i = 1; $i -le $version_num; $i++){
	Copy-Item "./$folder" -Destination "./$i" -Recurse
	cd $i
	$temp = $i * $gap
	git checkout head~$temp
	Remove-Item "./.git" -Recurse -Force			#刪除.git檔案
	cd ..
	echo "./$tar_folder/$i.tar"
	tar -cvf "./$tar_folder/$i.tar" "./$i"
	Remove-Item "./$i" -Recurse -Force
}
Remove-Item "./$folder" -Recurse -Force
pause
