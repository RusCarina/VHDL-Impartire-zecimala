library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity sumatorZecimal is
 Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
        Y : in STD_LOGIC_VECTOR (3 downto 0);
        Cin : in STD_LOGIC;
        S : out STD_LOGIC_VECTOR (3 downto 0);
        Cout : out STD_LOGIC);
end sumatorZecimal;

architecture Behavioral of sumatorZecimal is
signal sum,sum1 : std_logic_vector(3 downto 0) := "0000";
signal c,cc,ccc: std_logic:='0';

component sumator4bit is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end component;

begin
dut1: sumator4bit port map(x,y,cin,sum,c);
ccc <= c or (sum(3) and sum(2)) or (sum(3) and sum(1));
sum1 <= '0'& ccc & ccc & '0';

dut2: sumator4bit port map(sum1,sum,'0',s,cc);
cout<=ccc;

end Behavioral;