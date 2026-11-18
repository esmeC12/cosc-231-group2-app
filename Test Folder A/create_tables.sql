-- gym tracker database
-- tables based on our ER diagram

-- clear out old tables so this can be re-run (child tables first)
DROP TABLE IF EXISTS Friend;
DROP TABLE IF EXISTS SupportTicket;
DROP TABLE IF EXISTS Competition;
DROP TABLE IF EXISTS Achievement;
DROP TABLE IF EXISTS WorkoutExercise;
DROP TABLE IF EXISTS Exercise;
DROP TABLE IF EXISTS Workout;
DROP TABLE IF EXISTS Routine;
DROP TABLE IF EXISTS Goal;
DROP TABLE IF EXISTS User;

CREATE TABLE User (
    userId INTEGER PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Goal (
    goalId INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL,
    description VARCHAR(255) NOT NULL,
    targetDate DATE,
    completed INTEGER NOT NULL DEFAULT 0 CHECK (completed IN (0, 1)),
    FOREIGN KEY (userId) REFERENCES User(userId)
);

-- userId is empty for the built in routines everyone can see
CREATE TABLE Routine (
    routineId INTEGER PRIMARY KEY,
    userId INTEGER,
    name VARCHAR(50) NOT NULL,
    targetArea VARCHAR(50),
    details VARCHAR(500),
    FOREIGN KEY (userId) REFERENCES User(userId)
);

CREATE TABLE Workout (
    workoutId INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL,
    routineId INTEGER,
    workoutDate DATE NOT NULL,
    duration INTEGER,
    FOREIGN KEY (userId) REFERENCES User(userId),
    FOREIGN KEY (routineId) REFERENCES Routine(routineId)
);

CREATE TABLE Exercise (
    exerciseId INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    muscleGroup VARCHAR(50) NOT NULL
);

-- connects workouts and exercises
CREATE TABLE WorkoutExercise (
    workoutId INTEGER NOT NULL,
    exerciseId INTEGER NOT NULL,
    sets INTEGER,
    reps INTEGER,
    weight DECIMAL(5,1),
    PRIMARY KEY (workoutId, exerciseId),
    FOREIGN KEY (workoutId) REFERENCES Workout(workoutId),
    FOREIGN KEY (exerciseId) REFERENCES Exercise(exerciseId)
);

CREATE TABLE Achievement (
    achievementId INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    dateEarned DATE NOT NULL,
    FOREIGN KEY (userId) REFERENCES User(userId)
);

CREATE TABLE Competition (
    competitionId INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL,
    friendId INTEGER NOT NULL,
    type VARCHAR(50) NOT NULL,
    winner INTEGER,
    status VARCHAR(20) NOT NULL DEFAULT 'Active' CHECK (status IN ('Active', 'Completed')),
    FOREIGN KEY (userId) REFERENCES User(userId),
    FOREIGN KEY (friendId) REFERENCES User(userId),
    FOREIGN KEY (winner) REFERENCES User(userId)
);

CREATE TABLE SupportTicket (
    ticketId INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL,
    subject VARCHAR(100) NOT NULL,
    message VARCHAR(500) NOT NULL,
    status VARCHAR(20) DEFAULT 'Open',
    FOREIGN KEY (userId) REFERENCES User(userId)
);

-- friendships are saved both ways (one row for each person)
CREATE TABLE Friend (
    userId INTEGER NOT NULL,
    friendId INTEGER NOT NULL,
    PRIMARY KEY (userId, friendId),
    CHECK (userId <> friendId),
    FOREIGN KEY (userId) REFERENCES User(userId),
    FOREIGN KEY (friendId) REFERENCES User(userId)
);