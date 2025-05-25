#!/bin/bash
set -e
echo "Compilando arquivos..."
ghdl -a freq_div_05Hz.vhd tb_divisor_freq.vhd
ghdl -e tb_divisor_freq

echo "Executando simulação..."
ghdl -r tb_divisor_freq --vcd=wave.vcd

echo "Abrindo GTKWave..."
gtkwave wave.vcd
