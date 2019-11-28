# Tomasulo - Grupo B
- Allan Almeida Santos(8993497)
- Pedro Donini Linan (8993048)
- Pedro Duarte Bairao (8992840)
- Henrique Costabile Filho (8992670)

### Descrição

Esse projeto contém uma implementação do algoritmo Tomasulo em VHDL para a arquitetura Legv8. 

### Instruções para execução
- O projeto foi desenvolvido utilizando os softwares Quartus Prime Lite Edition e ModelSim-Altera.
- O projeto está contido no arquivo Tomasulo.qar. Para restaurá-lo, selecionar a opção Restore Archived Project no menu Project no Quartus
- O arquivo Tomasulo.vhd é a entidade Top-Level e o arquivo Tomasulo.tb é o arquivo de testbench utilizado para validação do projeto
- Para realizar a RTL Simulation, o software ModelSim-Altera é necessário. Em Settings no menu Assignments, selecionar a opção Simulation em EDA Tool Settings. Lá, selecionar ModelSim-Altera em Tool Name. Em Compile test bench, criar um novo testbench com o arquivo Tomasulo_tb sendo o módulo top-level.

### Descrição da simulação
- As instruções descritas no relatório são hard-coded em FIFO.vhd. 
- Todos os valores de registradores da Reg File, Map File, Registration Stations, CDB são sinais de saída juntamente com os sinais processados pelo Decoder. 
- Na interface do ModelSim-Altera, recomenda-se ajustar os sinais para representação decimal ou hexadecimal. Para mais informações sobre o tesbench, referir-se ao relatório anexo.