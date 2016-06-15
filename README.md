# xontrib-dotenv

Automatically reads .env file from current working directoryor parent directories, adds those variables to environment.

## Install

```shell
pip install xontrib-dotenv
```

Add those lines to your ```~/.xonshrc```:

```shell
xontrib load dotenv
$PROMPT=$PROMPT + '{dotenv}'
```

It won't modify the prompt, just load .env files each time prompt is rendered.
