#!/bin/bash
# springboot-shell v1.0.1-bash
# Link: https://github.com/frndpovoa/springboot-shell
# License: MIT
 
DEBUG=true
DIR="."
JAR="$DIR/demo-1.0.0-SNAPSHOT.jar"
PID="demo.pid"
JAVA_OPTS=" -Dspring.profiles.active=demo -Dspring.config.location=$DIR/ "


function erro() { echo "[ERRO] $1"; }
function warn() { echo "[WARN] $1"; }
function info() { echo "[INFO] $1"; }
function debug() { if [ DEBUG ]; then echo "[DEBUG] $1"; fi }


function processo() {
  local __ret=$1
  eval $__ret=$(<$PID);
}


function verif_se_arquivo_pid_existe() {
  if [ -f $PID ]; then
    return 0;
  else
    return 1;
  fi
}


function verif_se_processo_em_execucao() {
  if verif_se_arquivo_pid_existe && ps -p $1 > /dev/null; then
    return 0;
  else
    return 1;
  fi
}


function parar_processo_num1() {
  local __ret=$1
  local __parado=1

  info "Tentativa #1: $2 ";
  kill -TERM $2;

  for i in {1..120}; do
    if verif_se_processo_em_execucao $2; then
      printf ".";
      sleep 1;
    else
      __parado=0;
      break;
    fi
  done

  printf "\n"

  eval $__ret=\$__parado
}


function parar_processo_num2() {
  local __ret=$1
  local __parado=1

  info "Tentativa #2: $2 ";
  kill -SIGKILL $2;

  for i in {1..20}; do
    if verif_se_processo_em_execucao $2; then
      printf ".";
      sleep 1;
    else
      __parado=0;
      break;
    fi
  done

  printf "\n"

  eval $__ret=\$__parado
}


case "$1" in

  pid)

    if verif_se_arquivo_pid_existe; then
      processo proc
      info $proc
    fi
    
  ;;

  status)

    if verif_se_arquivo_pid_existe; then
      processo proc
      if verif_se_processo_em_execucao $proc; then
        info "Em execução!";
      else
        info "Parado!";
      fi
    fi

  ;;

  start)

    nohup java $JAVA_OPTS -jar $JAR &
    tail -f nohup.out

  ;;

  stop)

    if verif_se_arquivo_pid_existe; then
      processo proc
      if verif_se_processo_em_execucao $proc; then

        parado=1

        if [ $parado == 1 ]; then
          parar_processo_num1 parado $proc;
        fi

        if [ $parado == 1 ]; then
          parar_processo_num2 parado $proc;
        fi

        if [ $parado == 0 ]; then
          info "Parado!";
        fi

      fi
    fi

  ;;

  *)
    echo "Modo de uso: $0 {start|stop|status|pid}";

esac

exit 0
