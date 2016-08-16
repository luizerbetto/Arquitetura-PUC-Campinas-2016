# Teofanes Santos / Bruno Pedroso / Roger Luan / Luiz Felipe - 16/08/2016
# program.asm -- A "Fuel manager" program.

# Data for the program
.data
    hello_msg: .asciiz "Bem vindo\n"
               .asciiz "Escolha uma das opções abaixo:\n"
               .asciiz "1- Cadastrar abastecimento\n"
               .asciiz "2- Excluir abastecimento\n"
               .asciiz "3- Exibir abastecimentos\n"
               .asciiz "4- Exibir consumo médio\n"
               .asciiz "5- Exibir preço médio\n"
               .asciiz "6- Exibir ranking de postos\n"
    
.text

    .globl main
    
    main: la $a0, hello_msg #load the addr of hello_msg into $a0.
          li $v0, 4 #4 is the print_string syscall.
          syscall
    
    end: li $v0, 10 #10 is the exit syscall.
         syscall
        