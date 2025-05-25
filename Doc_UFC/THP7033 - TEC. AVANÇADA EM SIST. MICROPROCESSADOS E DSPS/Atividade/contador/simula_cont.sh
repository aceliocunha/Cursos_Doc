#!/bin/bash
set -e
echo "Compilando arquivos..."
ghdl -a contador.vhd db_contador.vhd
ghdl -e db_contador

echo "Executando simulação..."
ghdl -r db_contador --vcd=wave.vcd

echo "Abrindo GTKWave..."
gtkwave wave.vcd
