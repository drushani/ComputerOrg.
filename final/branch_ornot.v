module branch_ornot(rs, rt, branch, PCSrc);

input [4:0] rs, rt;
input branch;
output PCSrc;

assign PCSrc = ((rs==rt) && branch) ? 1:0;

endmodule 