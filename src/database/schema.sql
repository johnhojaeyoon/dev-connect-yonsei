
-- Freelancer Table Create SQL
CREATE TABLE Freelancer
(
  `idx`         INT             NOT NULL    AUTO_INCREMENT,
  `email`       VARCHAR(45)     NOT NULL    COMMENT 'Email address',
  `password`    VARCHAR(255)    NOT NULL    COMMENT 'Password',
  `name`        VARCHAR(45)     NOT NULL    COMMENT 'Name',
  `age`         INT             NOT NULL    COMMENT 'Age',
  `major`       VARCHAR(255)    NOT NULL    COMMENT 'Major',
  `phone`       VARCHAR(13)     NOT NULL    COMMENT 'Phone',
  `experience`  INT             NOT NULL    COMMENT 'Years of experience',
  `rating`      DOUBLE          NULL        COMMENT 'Rating',
  PRIMARY KEY (idx)
);


-- Client Table Create SQL
CREATE TABLE Client
(
  `idx`       INT             NOT NULL    AUTO_INCREMENT,
  `email`     VARCHAR(45)     NOT NULL    COMMENT 'Email address',
  `password`  VARCHAR(255)    NOT NULL    COMMENT 'Password',
  `name`      VARCHAR(100)    NOT NULL    COMMENT 'Name',
  `phone`     VARCHAR(13)     NOT NULL    COMMENT 'Phone',
  `rating`    DOUBLE          NULL        COMMENT 'Rating',
  PRIMARY KEY (idx)
);


-- Internal_project Table Create SQL
CREATE TABLE Internal_project
(
  `idx`         INT       NOT NULL    AUTO_INCREMENT,
  `client_idx`  INT       NOT NULL    COMMENT 'Client idx',
  `start_date`  DATE      NOT NULL    COMMENT 'Start date',
  `end_date`    DATE      NOT NULL    COMMENT 'End date',
  `min_part`    INT       NOT NULL    COMMENT 'Minimum participants',
  `max_part`    INT       NOT NULL    COMMENT 'Maximum participant',
  `experience`  INT       NOT NULL    COMMENT 'Years of experience',
  `pay`         DOUBLE    NOT NULL    COMMENT 'Pay',
  `req_doc`     BLOB      NOT NULL    COMMENT 'Request document',
  `status`      VARCHAR(15) NOT NULL COMMENT 'Status',
  `client_rating` DOUBLE NULL COMMENT 'Rating on client by freelancer',
  `freelancer_rating` DOUBLE NULL COMMENT 'Rating on freelancer by client',
  PRIMARY KEY (idx),
  FOREIGN KEY (client_idx) REFERENCES Client (idx)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Programming_language Table Create SQL
CREATE TABLE Programming_language
(
  `idx`   INT             NOT NULL    AUTO_INCREMENT,
  `name`  VARCHAR(100)    NOT NULL    COMMENT 'Name',
  PRIMARY KEY (idx)
);


-- Team Table Create SQL
CREATE TABLE Team
(
  `idx`         INT             NOT NULL    AUTO_INCREMENT,
  `name`        VARCHAR(255)    NOT NULL    COMMENT 'Name',
  `comment`     VARCHAR(255)    NULL        COMMENT 'Comment',
  `leader_idx`  INT             NOT NULL    COMMENT 'Leader',
  PRIMARY KEY (idx),
  FOREIGN KEY (leader_idx) REFERENCES Freelancer (idx)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- External_project Table Create SQL
CREATE TABLE External_project
(
  `idx`         INT             NOT NULL    AUTO_INCREMENT,
  `freelancer_idx`  INT    NOT NULL,
  `start_date`  DATE            NOT NULL    COMMENT 'Start date',
  `end_date`    DATE            NOT NULL    COMMENT 'End date',
  `pay`         DOUBLE          NOT NULL    COMMENT 'Pay',
  `attachment`  BLOB            NULL        COMMENT 'Attachment',
  `comment`     VARCHAR(255)    NULL        COMMENT 'Comment',
  PRIMARY KEY (idx)
);


-- Admin Table Create SQL
CREATE TABLE Admin
(
  `idx`       INT             NOT NULL    AUTO_INCREMENT,
  `email`     VARCHAR(45)     NOT NULL    COMMENT 'Email address',
  `password`  VARCHAR(255)    NOT NULL    COMMENT 'Password',
  `admin_key` VARCHAR(100) NOT NULL COMMENT 'Admin key',
  PRIMARY KEY (idx)
);



-- Portfolio Table Create SQL
-- Internal projects completed by freelancer or team
CREATE TABLE Completed_project
(
  `project_idx`  INT    NOT NULL,
  `freelancer_idx`   INT    NULL,
  `team_idx` INT NULL,
  FOREIGN KEY (project_idx)
  REFERENCES Internal_project (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (freelancer_idx)
  REFERENCES Freelancer (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (team_idx)
  REFERENCES Team (idx) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(project_idx, freelancer_idx, team_idx)
);



-- Team_member Table Create SQL
CREATE TABLE Team_member
(
  `team_idx`        INT    NOT NULL,
  `freelancer_idx`  INT    NOT NULL,
  FOREIGN KEY (team_idx)
  REFERENCES Team (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (freelancer_idx)
  REFERENCES Freelancer (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(team_idx, freelancer_idx)
);



-- Programming_language_knowledge Table Create SQL
CREATE TABLE Programming_language_knowledge
(
  `language_idx`    INT    NOT NULL,
  `freelancer_idx`  INT    NOT NULL,
  `proficiency`     INT    NOT NULL,
  FOREIGN KEY (language_idx)
  REFERENCES Programming_language (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (freelancer_idx)
  REFERENCES Freelancer (idx)  ON DELETE CASCADE ON UPDATE CASCADE
);


-- Internal_project_language_requirement Table Create SQL
CREATE TABLE Internal_project_language_requirement
(
  `project_idx`   INT    NOT NULL,
  `language_idx`  INT    NOT NULL,
  `proficiency`   INT    NOT NULL,
  FOREIGN KEY (project_idx)
  REFERENCES Internal_project (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (language_idx)
  REFERENCES Programming_language (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(project_idx, language_idx)
);



-- Current_project Table Create SQL
CREATE TABLE Current_project
(
  `project_idx`     INT    NOT NULL,
  `single_only`     BIT    NOT NULL,
  `team_only`       BIT    NOT NULL,
  `freelancer_idx`  INT    NULL,
  `team_idx`        INT    NULL,
  FOREIGN KEY (freelancer_idx)
  REFERENCES Freelancer (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (project_idx)
  REFERENCES Internal_project (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (team_idx)
  REFERENCES Team (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE (project_idx, freelancer_idx, team_idx)
);

CREATE TABLE Application (
  `project_idx` INT NOT NULL,
  `freelancer_or_team` VARCHAR(15) NOT NULL,
  `freelancer_idx`  INT    NULL,
  `team_idx`        INT    NULL,
  FOREIGN KEY (freelancer_idx)
  REFERENCES Freelancer (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (project_idx)
  REFERENCES Internal_project (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (team_idx)
  REFERENCES Team (idx)  ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE (project_idx, freelancer_idx, team_idx)
)