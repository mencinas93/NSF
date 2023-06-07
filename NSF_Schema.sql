create table Researcher
(Researcher_ID int(8),
Researcher_Name varchar(20) not null,
primary key (Researcher_ID)
);

create table Directorate 
(Directorate_ID int(8),
Directorate_Name varchar(20) not null,
primary key(Directorate_ID)
);

create table University 
(
University_ID int(6),
University_Name varchar(30) not null,
University_Address varchar(15),
University_City varchar(15),
University_State varchar(15),
primary key(University_ID)
);

create table NSF_Program
(
    Program_ID int(10),
    Program_Name varchar(30) not null,
    Description_Of_Program varchar (100),
    Directorate_ID int(8),
    primary key(Program_ID),
    foreign key (Directorate_ID) references Directorate (Directorate_ID)
    on delete set null
);

create table Proposal
(
    Proposal_ID int(10),
    Title varchar(25),
    Narrative varchar(100),
    Researcher_ID int(8),
    Program_ID int(10),
    primary key(Proposal_ID),
    foreign key (Researcher_ID) references Researcher (Researcher_ID) on delete cascade,
    foreign key (Program_ID) references NSF_Program (Program_ID)

);

create table Peer_Reviewers
(
    Peer_Reviewer_ID int(8),
    Peer_Reviewer_Name varchar(25) not null,
    Proposal_ID int(10),
    primary key (Peer_Reviewer_ID),
    foreign key (Proposal_ID) references Proposal (Proposal_ID) on delete cascade
);

create table Evaluation 
(
    Evaluation_ID int(8),
    Proposal_ID int(10),
    Peer_Reviewer_ID int(8),
    Directorate_ID int(8),
    Evaluation_Details varchar(100),
    primary key (Evaluation_ID, Proposal_ID, Peer_Reviewer_ID, Directorate_ID),
    foreign key (Proposal_ID) references Proposal(Program_ID)
    on delete cascade,
    foreign key (Peer_Reviewer_ID) references Peer_Reviewers(Peer_Reviewer_ID), 
    on delete casecade,
    foreign key (Directorate_ID) references Directorate(Directorate_ID)
    on delete set null
);

create table Approval
(
    Approval_ID int(8),
    Directorate_ID int(8),
    Evaluation_ID int(8),
    Dates varchar (8),
    time_slot_id varchar(4),
    primary key (Approval_ID, Directorate_ID, Evaluation_ID),
    foreign key (Directorate_ID) references Directorate(Directorate_ID)
    on delete set cascade,
    foreign key (Evaluation_ID) references Evaluation(Evaluation_ID)
    on delete cascade
);

create table NSF_Grants
(
    Grant_ID int(8),
    Money_Given numeric (8,2),
    University_ID int(6),
    primary key (Grant_ID), 
    foreign key (University_ID) references University(University_ID)
    on delete cascade
);

create table Managers_NSF
(
    Managers_ID int(8)
    Managers_Name varchar (20) not null,
    University_ID int (6),
    Approval_ID int(8),
    Grant_ID int (8),
    Primary key (Managers_ID, University_ID, Approval_ID, Grant_ID),
    foreign key (University_ID) references University(University_ID)
    on delete cascade,
    foreign key (Approval_ID) references Approval(Approval_ID)
    on delete cascade,
    foreign key (Grant_ID) references NSF_Grants (Grant_ID)
    on delete cascade
);

create table Principle Investigator
(
    PI_ID int (8),
    PI_Name varchar (20) not null,
    Title varchar (30),
    Budget numeric(9,2),
    Grant_ID int(8),
    University_ID int (6),
    Primary Key (PI_ID, Grant_ID, University_ID),
    foreign key (Grant_ID) references NSF_Grants(Grant_ID)
    on delete cascade,
    foreign key (University_ID) references University (University_ID)
    on delete set null
);