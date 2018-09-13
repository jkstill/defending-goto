select '''' || dbms_random.string('l',3)  || ''''
from dual
connect by level <= 10
/
