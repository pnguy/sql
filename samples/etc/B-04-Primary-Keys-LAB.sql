alter table dbo.ClientContact alter column ClientId int not null;
alter table dbo.ClientContact alter column EntityTypeId int not null;
alter table dbo.ClientContact add constraint PK_ClientContact primary key (ClientId, EntityTypeId);

alter table dbo.Address alter column AddressId int not null;
alter table dbo.Address add primary key (AddressId);

alter table dbo.Phone alter column PhoneId int not null;
alter table dbo.Phone add primary key (PhoneId);

alter table dbo.Project alter column ProjectId int not null;
alter table dbo.Project add primary key (ProjectId);

alter table dbo.ProjectStatus alter column ProjectStatusId int not null;
alter table dbo.ProjectStatus add primary key (ProjectStatusId);

alter table dbo.EmployeeProject alter column EmployeeProjectId int not null;
alter table dbo.EmployeeProject add primary key (EmployeeProjectId);

alter table dbo.Review alter column ReviewId int not null;
alter table dbo.Review add primary key (ReviewId);

alter table dbo.ReviewData alter column ReviewId int not null;
alter table dbo.ReviewData alter column EntityTypeId int not null;
alter table dbo.ReviewData add constraint PK_ReviewData primary key (ReviewId, EntityTypeId);

alter table dbo.Training alter column TrainingId int not null;
alter table dbo.Training add primary key (TrainingId);

alter table dbo.TrainingData alter column TrainingId int not null;
alter table dbo.TrainingData alter column EntityTypeId int not null;
alter table dbo.TrainingData add constraint PK_TrainingData primary key (TrainingId, EntityTypeId);

alter table dbo.Vehicle alter column VehicleId int not null;
alter table dbo.Vehicle add primary key (VehicleId);

alter table dbo.VehicleModel alter column VehicleModelId int not null;
alter table dbo.VehicleModel add primary key (VehicleModelId);

alter table dbo.VehicleMake alter column VehicleMakeId int not null;
alter table dbo.VehicleMake add primary key (VehicleMakeId);

alter table dbo.VehicleStatus alter column VehicleStatusId int not null;
alter table dbo.VehicleStatus add primary key (VehicleStatusId);


