library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity impartireaCuRefacere is
generic(n : natural:= 20);
 Port ( 
 clk: in std_logic;
 rst : in STD_LOGIC;
 start : in STD_LOGIC;
 x : in STD_LOGIC_VECTOR(n-1 downto 0);
 y : in STD_LOGIC_VECTOR(n-1 downto 0);
 a : out STD_LOGIC_VECTOR(n-1 downto 0);
 q : out STD_LOGIC_VECTOR(n-1 downto 0);
 Term : out STD_LOGIC);
end impartireaCuRefacere;

architecture Behavioral of impartireaCuRefacere is

signal loada,loadb,loadq,shla,shlq,subb,ovf,selmuxin: std_logic :='0';
signal an,outsuman: std_logic:='1';
signal outb,insum,outsum,outq: std_logic_vector(n-1 downto 0);
signal outa,ina: std_logic_vector(n downto 0);
signal nn: std_logic_vector(3 downto 0):=(others =>'0'); 

component unitateDeControlCuRefacere is
generic(n: natural);
Port(
    start: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    an: in std_logic;
    selmuxin: out std_logic;
    loadA,loadB,loadQ: out std_logic;
    shla,shlq: out std_logic;
    subb:out std_logic;
    term: out std_logic;
    nn: out std_logic_vector(3 downto 0)
    );
end component;

component registruDeplasareStanga is
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
end component;

component registru is
 GENERIC ( n : natural ) ;
 Port (
 d: in std_logic_vector(n-1 downto 0);
 ce: in std_logic;
 clk: in std_logic;
 rst: in std_logic;
 q: out std_logic_vector(n-1 downto 0)
 );
end component;

component sumator_16biti is
  Port (
    X : in STD_LOGIC_VECTOR (19 downto 0);
    Y : in STD_LOGIC_VECTOR (19 downto 0);
    Cin : in STD_LOGIC;
    S : out STD_LOGIC_VECTOR (19 downto 0);
    Cout : out STD_LOGIC
  );
end component;

begin

unitateDeControl: unitateDeControlCuRefacere generic map ( n => n) port map (start=>start,clk=>clk,rst=>rst,an=>an,
selmuxin=>selmuxin,loada=>loada,loadb=>loadb,loadq=>loadq,shla=>shla,shlq=>shlq,subb=>subb,term=>term,nn=>nn);

registrulb: registru generic map(n => n) port map(d=>y,ce=>loadb,clk=>clk,rst=>rst,q=>outb);

insum <= x"99999" - outB when subb = '1' else outB;

suma: sumator_16biti port map( x=>outa(n-1 downto 0),y=>insum,cin=>subb,s=>outsum, cout=>outsuman);
 
an<=outsum(n-1) or outsum(n-2) or outsum(n-3) or outsum(n-4) ; 
ina <= '0' & x"00000" when selmuxin = '1' else an & outsum;

registrula: registruDeplasareStanga generic map(n => n+1) port map( d => ina,sri=> outq(n-1 downto n-4),load=>loada,
 ce=>shla,clk=>clk,rst=>rst,q=>outa);
 
registrulq: registruDeplasareStanga generic map(n => n) port map( d => x,sri=> nn,load=>loadq,ce=>shlq,clk=>clk,
 rst=>rst,q=>outq); 
 
q<=outq;
a<= outa(n-1 downto 0); 

end Behavioral;























--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.std_logic_unsigned.all;

--entity impartireaCuRefacere is
--generic(n : natural:= 20);
-- Port ( 
-- clk: in std_logic;
-- rst : in STD_LOGIC;
-- start : in STD_LOGIC;
-- x : in STD_LOGIC_VECTOR(n-1 downto 0);
-- y : in STD_LOGIC_VECTOR(n-1 downto 0);
-- a : out STD_LOGIC_VECTOR(n-1 downto 0);
-- q : out STD_LOGIC_VECTOR(n-1 downto 0);
-- Term : out STD_LOGIC);
--end impartireaCuRefacere;

--architecture Behavioral of impartireaCuRefacere is
--signal loada, loadb, loadq, shla, shlq, subb, ovf, selmuxin: std_logic := '0';
--signal an, outsuman: std_logic := '1';
--signal outb, insum, outsum, outq: std_logic_vector(31 downto 0);
--signal outa, ina: std_logic_vector(n downto 0);
--signal nn: std_logic_vector(3 downto 0) := (others => '0'); 

--component unitateDeControlCuRefacere is
--generic(n: natural := n);
--    port(
--      start: in std_logic;
--      clk: in std_logic;
--      rst: in std_logic;
--      an: out std_logic;
--      selmuxin: out std_logic;
--      loada: out std_logic;
--      loadb: out std_logic;
--      loadq: out std_logic;
--      shla: out std_logic;
--      shlq: out std_logic;
--      subb: out std_logic;
--      term: out std_logic;
--      nn: out std_logic_vector(3 downto 0)
--    );
--end component;

--component registru is
--GENERIC ( n : natural := n ) ;
--    port(
--      d: in std_logic_vector(n-1 downto 0);
--      ce: in std_logic;
--      clk: in std_logic;
--      rst: in std_logic;
--      q: out std_logic_vector(n-1 downto 0)
--    );
--end component;

--component sumator16bit is
--    port(
--      x: in std_logic_vector(19 downto 0);
--      y: in std_logic_vector(19 downto 0);
--      cin: in std_logic;
--      s: out std_logic_vector(19 downto 0);
--      cout: out std_logic
--    );
--end component;

--component registruDeplasareStanga is
--GENERIC ( n : natural ) ;
-- Port (
-- d: in std_logic_vector(n-1 downto 0);
-- sri: in std_logic_vector(3 downto 0);
-- load: in std_logic;
-- ce: in std_logic;
-- clk: in std_logic;
-- rst: in std_logic;
-- q: out std_logic_vector(n-1 downto 0)
-- );
--end component;

--begin
--  unitateDeControl_inst: unitateDeControlCuRefacere 
--    port map(
--      start => start,
--      clk => clk,
--      rst => rst,
--      an => an,
--      selmuxin => selmuxin,
--      loada => loada,
--      loadb => loadb,
--      loadq => loadq,
--      shla => shla,
--      shlq => shlq,
--      subb => subb,
--      term => Term,
--      nn => nn
--    );

--registrulb_inst: registru 
--    port map(
--      d => y,
--      ce => loadb,
--      clk => clk,
--      rst => rst,
--      q => outb
--);

--insum <= x"99999" - outB when subb = '1' else outB;

--suma_inst: sumator16bit 
--    port map(
--      x => outa(31 downto 16),
--      y => insum,
--      cin => subb,
--      s => outsum,
--      cout => outsuman
--);

--an <= outsum(31) or outsum(30) or outsum(29) or outsum(28);
--ina <= '0' & x"00000" when selmuxin = '1' else an & outsum;

--registrula_inst: registruDeplasareStanga 
--    generic map (
--  n => n+1
--)    port map(
--      d => ina,
--      sri => outq(31 downto 28),
--      load => loada,
--      ce => shla,
--      clk => clk,
--      rst => rst,
--      q => outa
--    );

--registrulq_inst: registruDeplasareStanga 
--    generic map (
--  n => n
--)    port map(
--      d => x,
--      sri => nn,
--      load => loadq,
--      ce => shlq,
--      clk => clk,
--      rst => rst,
--      q => outq
--    );

--q <= outq;
--a <= outa(31 downto 0);

--end Behavioral;
