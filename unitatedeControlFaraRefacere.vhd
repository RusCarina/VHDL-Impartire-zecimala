library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity unitateDeControlFaraRefacere is
generic(n: natural);
 Port ( 
 start,clk,rst: in std_logic;
 an: in std_logic;
 selmuxin: out std_logic;
 loadA,loadB,loadQ: out std_logic;
 shla,shlq: out std_logic;
 subb:out std_logic;
 term: out std_logic;
 nn: out std_logic_vector(3 downto 0) 
 );
end unitateDeControlFaraRefacere;

architecture Behavioral of unitateDeControlFaraRefacere is

type tip_stare is 
(idle,initializare,shiftareA,decizie1,verifbs,scadere,adunare,cifracat,comparare,stop);
signal stare: tip_stare;
signal cn: natural:=5;
signal t: std_logic:='0';
signal n1 : std_logic_vector(3 downto 0):="0000";
signal bistabil : std_logic := '1';
begin

process(clk,rst,start,an)
begin 
 if rising_edge(clk) then
    if rst = '1' then 
        stare<=idle;
    end if;
    case stare is 
        when idle =>
            t <= '0';
            loada <= '0';
            loadb <= '0';
            loadq <= '0';
            shla <= '0';
            shlq <= '0'; 
            subb <= '0';
            selmuxin <= '0';
            n1<=(others =>'0');
            nn<="0000";
            cn <= 4;
            if start = '1' then 
                stare <= initializare;
            else 
                stare <= idle;
            end if;
        when initializare =>
            loada <= '1';
            loadb <= '1';
            loadq <= '1';
            selmuxin <= '1';
            shla <= '0';
            shlq <= '0'; 
            subb <= '0';
            n1<="0000";
            bistabil<='0';
            stare <= shiftareA; 
        when shiftareA =>
            loada <= '0';
            loadb <= '0';
            loadq <= '0';
            shla <= '1';
            shlq <= '0'; 
            subb <= '0';
            selmuxin <= '0';
            n1<="0000";
            stare <= decizie1; 
         when decizie1 =>
            loada <= '0';
            loadb <= '0';
            loadq <= '0';
            shla <= '0';
            shlq <= '0';
            subb <= '0';
            selmuxin <= '0';
            if an = bistabil then 
                stare <= verifbs;
            else
                stare <= cifracat; 
            end if;
         when verifbs => 
            loada <= '0';
            loadb <= '0';
            loadq <= '0';
            shla <= '0';
            shlq <= '0';
            subb <= '0';
            selmuxin <= '0';
            n1<= n1 + 1;
            if(an ='1') then 
                stare <= adunare;
            else 
                stare <= scadere;
            end if;
        when scadere =>
            loada <= '1';
            loadb <= '0';
            loadq <= '0';
            shla <= '0';
            shlq <= '0';
            subb <= '1'; 
            selmuxin <= '0';
            stare <= decizie1;
        when adunare =>
            loada <= '1';
            loadb <= '0';
            loadq <= '0';
            shla <= '0';
            shlq <= '0';
            subb <= '0';
            stare <= decizie1; 
        when cifracat =>
            loada <= '0';
            loadb <= '0';
            loadq <= '0';
            shla <= '0';
            shlq <= '1';
            subb <= '0';
            selmuxin <= '0';
            stare <= comparare;
            if BS = '0' then
                  nn<= n1-2;
            else 
                  nn <= "1010" - n1;
            end if;
        when comparare =>
            loada <= '0';
            loadb <= '0';
            loadq <= '0';
            shla <= '0';
            shlq <= '0';
            subb <= '0';
            selmuxin <= '0';
            cn <= cn - 1;
            bistabil <= an;
            if cn = 0 then 
                stare <= stop;
            else 
                stare <= shiftareA;
            end if; 
        when stop =>
            t <= '1';
            loada <= '0';
            loadb <= '0';
            loadq <= '0';
            shla <= '0';
            shlq <= '0';
            subb <= '0';
            selmuxin <= '0';
        when others => stare <= idle; 
    end case;
 end if;
end process;

term <= t;
end Behavioral;
