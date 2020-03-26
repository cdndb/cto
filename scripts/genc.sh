
git remote remove origin
git remote add origin "https://cdndb:${password}@github.com/cdndb/cto.git"
git fetch origin cache
git pull origin master

if [ ! -d cache ] ;then mkdir cache;fi
echo -n [ > cache/.cache
for i in $(find ./ -name .url);  
    do echo -n '{"f":"'$(echo $i | sed 's/^\.\///' | sed 's/\/\.url$//')'","info":'$(cat $i)'},' >> cache/.cache ;
done 
cat cache/.cache | sed 's/,$//' > cache/cache.json 
echo -n ] >> cache/cache.json
rm cache/.cache
mv cache ../cache

git switch cache -f
cp -rf ../cache/* cache/ 
git add -A
git commit -m '[skip travis] build cache'
git push origin cache
