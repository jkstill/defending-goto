
set serveroutput on size unlimited

/*

Using two arrays, determine if there is a value in array 2 that is found in array 1

This is a brute force algorithm, but easy to follow


*/

declare

	type data_typ is table of varchar2(3) index by binary_integer;

	search_target data_typ;
	search_data data_typ;	

	b_match_found boolean := false;
	match_index integer := 0;
	
	iterations integer := 0;

begin

	-- populate the arrays
	search_target(1) := 'fhg';
	search_target(2) := 'zor';
	search_target(3) := 'wef';
	search_target(4) := 'wxv';
	search_target(5) := 'edv';
	search_target(6) := 'qzi';
	search_target(7) := 'owf';
	search_target(8) := 'lax';
	search_target(9) := 'iwn';
	search_target(10) := 'lwb';

	search_data(1) := 'xre';
	search_data(2) := 'umf';
	search_data(3) := 'pnp';
	search_data(4) := 'lts';
	search_data(5) := 'plm';
	search_data(6) := 'qzi'; -- this one matches search_target(6)
	search_data(7) := 'xxv';
	search_data(8) := 'usy';
	search_data(9) := 'nnd';
	search_data(10) := 'ukk';


	-- with goto
	for x in search_target.first .. search_target.last
	loop
		iterations := iterations + 1;
		for y in search_data.first .. search_data.last
		loop
			iterations := iterations + 1;
			if search_data(y) = search_target(x) then
				match_index := x;
				goto MATCH_FOUND;
			end if;
		end loop;
	end loop;
	<<MATCH_FOUND>>

	dbms_output.put_line('found match with goto in search_target(' || to_char(match_index) || ') in ' || to_char(iterations) || ' iterations');

	-- without goto	
	iterations := 0;
	for x in search_target.first .. search_target.last
	loop
		iterations := iterations + 1;
		for y in search_data.first .. search_data.last
		loop
			iterations := iterations + 1;
			if search_data(y) = search_target(x) then
				match_index := x;
				b_match_found := true;
			end if;
			if b_match_found then
				exit;
			end if;
		end loop;
		if b_match_found then
			exit;
		end if;
	end loop;


	dbms_output.put_line('found match WITHOUT goto in search_target(' || to_char(match_index) || ')' || to_char(iterations) || ' iterations');

	
end;
/

