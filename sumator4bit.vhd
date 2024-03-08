library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity sumator4bit is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end sumator4bit;

architecture Behavioral of sumator4bit is

    signal carry: std_logic_vector(3 downto 0) := "0000";

    component sumator1bit
        Port ( X : in STD_LOGIC;
               Y : in STD_LOGIC;
               Cin : in STD_LOGIC;
               S : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end component;

begin

    generate_loop: for i in 0 to 3 generate
        first: if i = 0 generate 
            U1: sumator1bit port map (X(i), Y(i), Cin, S(i), carry(i));
        end generate first;
        second: if i > 0 generate
            U2: sumator1bit port map (X(i), Y(i), carry(i-1), S(i), carry(i));
        end generate second;
    end generate generate_loop;

    Cout <= carry(3);

end Behavioral;