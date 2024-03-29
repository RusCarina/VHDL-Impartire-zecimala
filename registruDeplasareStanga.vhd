library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registruDeplasareStanga is
GENERIC ( n : natural ) ;
 Port (
 d: in std_logic_vector(n-1 downto 0);
 sri: in std_logic_vector(3 downto 0);
 load: in std_logic;
 ce: in std_logic;
 clk: in std_logic;
 rst: in std_logic;
 q: out std_logic_vector(n-1 downto 0)
 );
end registruDeplasareStanga;

architecture Behavioral of registruDeplasareStanga is

signal iesire: std_logic_vector(n-1 downto 0) := (others => '0');

begin

process(d, sri, load, ce, rst, clk)
begin
    if clk'event and clk = '1' then
        if rst = '1' then
            iesire <= (others => '0');
        elsif load = '1' then
            iesire <= d;
        elsif ce = '1' then
            iesire <= iesire(n-5 downto 0) & sri;
        end if;
    end if;
end process;

q <= iesire;    

end Behavioral;