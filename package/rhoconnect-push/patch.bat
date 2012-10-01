set path=%path%
echo %path%
for %%i in (rhoconnect-push\rhoconnect-push-*.tgz) do npm install -g %%i
rhoconnect-push -c ./rhoconnect-push/config.json
