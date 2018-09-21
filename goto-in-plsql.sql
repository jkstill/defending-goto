
set serveroutput on size unlimited
set feedback off

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


	procedure p_results(
		element_index_in number, 
		iterations_in number,
		method_in varchar2
	)
	is
	begin

		if 
			( element_index_in is NULL ) 
			or
			( iterations_in is NULL ) 
			or
			( method_in is NULL ) 
		then
			raise_application_error(-20001,'do not call p_results with NULL arguments');
		end if;

		dbms_output.put_line('found match using "' || method_in || '"  in search_target(' || to_char(element_index_in) || ') ' || to_char(iterations_in) || ' iterations');

	end;

	procedure p_blank_line
	is
	begin
		dbms_output.put_line(chr(9));
	end;

	procedure banner 
	is
	begin
		dbms_output.put_line(rpad('=',80,'='));
	end;

	procedure p_out (
		search_target_in varchar2,
		search_result_in varchar2
	)
	is
	begin

		if 
			( search_target_in is NULL ) 
			or
			( search_result_in is NULL ) 
		then
			raise_application_error(-20000,'do not call p_out with NULL arguments');
		end if;

		dbms_output.put_line('target: ' || search_target_in);
		dbms_output.put_line('result: ' || search_result_in);

	end;

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

	banner;

	-- with goto
	for x in search_target.first .. search_target.last
	loop
		iterations := iterations + 1;
		for y in search_data.first .. search_data.last
		loop
			iterations := iterations + 1;
			if search_data(y) = search_target(x) then
				match_index := x;
				p_out(search_target(x), search_data(y));
				goto MATCH_FOUND;
			end if;
		end loop;
	end loop;
	-- this bit is easy with GOTO 
	-- this code executes only if no match is found
	dbms_output.put_line('No Match Found!');
	<<MATCH_FOUND>>

	p_results(match_index,iterations,'GOTO');

	banner;
	-- without goto	
	iterations := 0;
	match_index := 0;
	for x in search_target.first .. search_target.last
	loop
		iterations := iterations + 1;
		for y in search_data.first .. search_data.last
		loop
			iterations := iterations + 1;
			if search_data(y) = search_target(x) then
				match_index := x;
				b_match_found := true;
				p_out(search_target(x), search_data(y));
				exit;
			end if;
		end loop;
		if b_match_found then
			exit;
		end if;
	end loop;

	p_results(match_index,iterations,'BOOLEAN IF-THEN');

	banner;

	-- without goto 
	iterations := 0;
	match_index := 0;
	<<OUTERLOOP>>
	for x in search_target.first .. search_target.last
	loop
		iterations := iterations + 1;
		<<INNERLOOP>>
		for y in search_data.first .. search_data.last
		loop
			iterations := iterations + 1;
			if search_data(y) = search_target(x) then
				match_index := x;
				p_out(search_target(x), search_data(y));
				exit OUTERLOOP;
			end if;
		end loop;
	end loop;


	p_results(match_index,iterations,'exit LOOP LABEL');
	p_blank_line;

	
end;
/

