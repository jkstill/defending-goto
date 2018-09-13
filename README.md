
# In Defense of GOTO

Recently I was taken to task for using a GOTO in some PL/SQL.

I was forced to remove the GOTO, even though the code was much more clear and understandable with the GOTO than without it.

Here is an interesting email exchange defending the use of GOTO in the Linux kernel

(Using goto in Linux Kernel Code)[http://koblents.com/Ches/Links/Month-Mar-2013/20-Using-Goto-in-Linux-Kernel-Code/]

The body of that page is included in two files found in this repo, one in HTML and the other in text.

The following command was used to retrieve just the text:

```bash
lynx -dump -nolist  http://koblents.com/Ches/Links/Month-Mar-2013/20-Using-Goto-in-Linux-Kernel-Code/ > using-goto-linux-kernel-code.txt
```


The file goto-in-plsql.sql has a demonstration of a double loop in pl/sql where the GOTO version is much easier to follow.

Like any feature when abused, goto can create spaghetti code.

When used properly, goto cuts through the clutter and creates more readable code.

From the file goto-in-plsql.sql:

## with GOTO

```sql

   for x in search_target.first .. search_target.last
   loop
      for y in search_data.first .. search_data.last
      loop
         if search_data(y) = search_target(x) then
            match_index := x;
            goto MATCH_FOUND;
         end if;
      end loop;
   end loop;
   <<MATCH_FOUND>>

```

## without GOTO

```sql
   for x in search_target.first .. search_target.last
   loop
      for y in search_data.first .. search_data.last
      loop
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
```



