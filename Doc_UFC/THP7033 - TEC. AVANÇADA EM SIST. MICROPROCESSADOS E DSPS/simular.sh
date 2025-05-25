#!/bin/bash
set -e

echo "Compilando arquivos..."
ghdl -a and_gate.vhd tb_and_gate.vhd
ghdl -e tb_and_gate

echo "Executando simulação..."
ghdl -r tb_and_gate --vcd=wave.vcd

echo "Abrindo GTKWave..."
gtkwave wave.vcd
