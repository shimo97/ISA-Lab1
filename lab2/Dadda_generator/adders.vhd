LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY FA IS
PORT(I1 : IN std_logic;
I2 : IN std_logic;
Cin : IN std_logic;
Q : OUT std_logic;
Cout : OUT std_logic);
END FA;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY HA IS
PORT(I1 : IN std_logic;
I2 : IN std_logic;
Q : OUT std_logic;
Cout : OUT std_logic);
END HA;

--architectures-------------------------------------

ARCHITECTURE beh of FA IS

SIGNAL P : std_logic;

BEGIN

P<=(I1 xor I2);
Q<=P xor Cin;
Cout<=(Cin and P) or (I1 and I2);

END beh;

ARCHITECTURE beh of HA IS
BEGIN
Q<=I1 xor I2;
Cout<=I1 and I2;
END beh;