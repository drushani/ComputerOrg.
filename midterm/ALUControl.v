`timescale 1ns/1ns
module ALUControl( clk, reset, signal, signaltoALU, signaltoSHT, signaltoMTP, signaltoMUX ) ;

input clk ;
input [5:0] signal ;
output [5:0] signaltoALU, signaltoSHT, signaltoMTP, signaltoMUX;
output reset ;
reg [6:0] counter ;
reg [5:0] temp ; // �ΨӼȦs�T��
reg rst ;

parameter MULTU = 6'b011001 ;

// signal�@�����ܤ~�|�i�Jalways�̭�
always @( signal )
begin
  if ( signal == MULTU )
  begin
    counter = 0 ; // initial
	rst = 1 ;
  end
end

/*
�@��clk�X�{�W�ɤ@���A�N���T����J�@��
�p�G�T���O���k�����A��J32������N�n�⵲�G��JHiLo�̭�
�p�G�OAdd, Sub, And, Or, Slt���T���N���|�i�Jif()����y
�ҥHsignaltoALU�N�|�O�䤤�@�ت��T��
�άOSrl�A�N�|�OsignaltoSHT���@�ذT��
*/
always @( posedge clk )
begin
  temp = signal ;
  if ( signal == MULTU )
  begin
	if ( counter != 0 )
	  rst = 0 ;
  
    counter = counter + 1 ;
	if ( counter >= 32 )
	begin
	  temp = 6'b111111 ; // ���A���T���h���B��
	end
  end
end

/*
���O���F�n�����檺�a��H�~�A�]�n���h�u����
�o�ˤ~�i�H���D�̲׭n��X�����G�O����
*/
assign signaltoALU = temp ;
assign signaltoMTP = temp ;
assign signaltoSHT = temp ;
assign signaltoMUX = temp ;

assign reset = rst ;

endmodule