# Urban Terror Dedicated Server Docker Image

## Example Usage

```
docker run --rm -it -p 0.0.0.0:27960:27960/udp asnapper/urbanterror-server \
    +set dedicated 2 \
    +set ttycon 0 \
    +map ut4_casa
```

## Advanced Configuration

- set HOME environment variable
- mount volume with autoexec.cfg and/or default.cfg into $HOME/.q3a/q3ut4

## Known Issues

- ioquake can't resolve master server dns (not an issue if you don't want your server to be publicliy listed)