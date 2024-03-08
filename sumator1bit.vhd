library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity sumator1bit is
 Port ( 
 X : in STD_LOGIC;
 Y : in STD_LOGIC;
 Cin : in STD_LOGIC;
 S : out STD_LOGIC;
 Cout : out STD_LOGIC);
end sumator1bit;

architecture Behavioral of sumator1bit is
begin

S <= X xor Y xor Cin;
Cout <= (X and Y) or (X and Cin) or (Y and cin);

end Behavioral;
