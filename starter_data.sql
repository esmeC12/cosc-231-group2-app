-- starter data so the app has stuff to show

INSERT INTO Exercise (name, muscleGroup) VALUES
('Bench Press', 'Chest'),
('Incline Dumbbell Press', 'Chest'),
('Push Ups', 'Chest'),
('Pull Ups', 'Back'),
('Barbell Row', 'Back'),
('Lat Pulldown', 'Back'),
('Squat', 'Legs'),
('Goblet Squat', 'Legs'),
('Romanian Deadlift', 'Legs'),
('Overhead Press', 'Shoulders'),
('Lateral Raise', 'Shoulders'),
('Bicep Curl', 'Arms'),
('Tricep Pushdown', 'Arms'),
('Kettlebell Swing', 'Full Body'),
('Plank', 'Core');

-- test users (password is the same)
INSERT INTO User (firstName, lastName, email, username, password) VALUES
('Tyler', 'Test', 'tyler.test@gmail.com', 'tylertest', 'test123'),
('Esme', 'Test', 'esme.test@gmail.com', 'esmetest', 'test123'),
('Blake', 'Test', 'blake.test@gmail.com', 'blaketest', 'test123'),
('Carter', 'Test', 'carter.test@gmail.com', 'cartertest', 'test123'),
('Chris', 'Test', 'chris.test@gmail.com', 'christest', 'test123');

-- default routines plus my own
INSERT INTO Routine (userId, name, targetArea, details) VALUES
(NULL, 'Push Day', 'Chest', 'Bench press, incline dumbbell press, tricep pushdown'),
(NULL, 'Pull Day', 'Back', 'Pull ups, barbell row, lat pulldown, bicep curl'),
(NULL, 'Leg Day', 'Legs', 'Squat, romanian deadlift, goblet squat'),
(NULL, 'Kettlebell Full Body', 'Full Body', 'Kettlebell swings, goblet squats, plank'),
(1, 'Morning Routine', NULL, '50 push ups and a 1 minute plank'),
(1, 'Saturday Routine', NULL, 'Long kettlebell session');

INSERT INTO Goal (userId, description, targetDate, completed) VALUES
(1, 'Bench 185 for reps', '2027-03-01', 0),
(1, 'Kettlebell workout 4x a week', '2026-12-31', 0),
(1, 'Log my first workout', '2026-11-15', 1);

INSERT INTO Workout (userId, routineId, workoutDate, duration) VALUES
(1, 1, '2026-11-09', 50),
(1, 4, '2026-11-10', 30),
(1, NULL, '2026-11-11', 10);

INSERT INTO WorkoutExercise (workoutId, exerciseId, sets, reps, weight) VALUES
(1, 1, 3, 8, 155),
(1, 2, 3, 10, 50),
(1, 13, 3, 12, 40),
(2, 14, 4, 15, 35),
(2, 8, 3, 12, 35),
(2, 15, 3, 1, NULL),
(3, 3, 3, 20, NULL);

INSERT INTO Achievement (userId, name, dateEarned) VALUES
(1, 'First Workout', '2026-11-09');

-- adding certain friends
INSERT INTO Friend (userId, friendId) VALUES
(1, 2), (2, 1),
(1, 3), (3, 1),
(1, 5), (5, 1);

INSERT INTO Competition (userId, friendId, type, winner, status) VALUES
(1, 5, 'Push ups in a minute', 1, 'Completed'),
(1, 5, 'Workouts completed in a day', 5, 'Completed'),
(1, 2, 'Squats in a minute', NULL, 'Active');

INSERT INTO SupportTicket (userId, subject, message, status) VALUES
(1, 'Workout not saving', 'logged my leg day and it didnt show up', 'Closed'),
(1, 'Cant add friend', 'add friend button doesnt do anything', 'Open');