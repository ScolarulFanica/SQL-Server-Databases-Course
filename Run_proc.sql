use TableTennis
go

Execute do_proc_1
go
Execute undo_proc_1
go
Execute do_proc_2
go
Execute undo_proc_2
go
Execute do_proc_3
go
Execute undo_proc_3
go
Execute do_proc_4
go
Execute undo_proc_4
go
Execute do_proc_5
go
Execute undo_proc_5
go
Execute do_proc_6
go
Execute undo_proc_6
go
Execute do_proc_7
go
Execute undo_proc_7

main 2
ALTER TABLE Player
DROP column DateOfBirth
ALTER TABLE Rankings
DROP column ClubName