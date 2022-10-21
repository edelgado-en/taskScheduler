# taskScheduler
Group Project COP4655

test

Overview:
A user can be either a manager or an employee
A manager creates and assigns jobs to employee.
An employee can have multiple jobs assigned to him/her.
A job can only be assign to one employee.
A job can have one or more tasks.
A job can have one or more status activities.
A job can have one or more comments.
A job can have one or more photos. (nice to have)
A job status activity has an id, status, user, timestamp
A tasks has an id, name and a status
A job has an id, name, status, description, one or more tasks, and an assignee

An employee can only see jobs assigned to him/her.
A manager can see all jobs in the queue.
A manager can see the id, name, and status of a job in the job listing
A manager can click on a job to see the job details view. In the details view, a manager can see all information about the job
From the details view, a user can click on the comments icon. Once the comments icon is clicked, the user will be redirected to the
comments view.
From the details view, a user can click on the activity icon. Once the activity icon is clicked, the user will be redirected to the
status activity view. In this view, you can see the status activity for the selected job.

USER STORY TEMPLATE:
    AS a <user>
    I WANT <action>
    SO THAT <reason>

    Acceptance Criteria:
    Explain what is it that needs to be tested

    Example:
    As a manager
    I want to see all jobs in the job listing view with the following information:
        id, name, status
    So that I can see all the jobs currently in the queue


Views:
login view (username, password, button, logo)
Signup view (username, password, button, dropdown to select manager or employee)

Job Listing (table view of each job)
    Has a logout button on the top right of the view
    Has an "Add job" button on the top right of the view (only visible to managers)
    Each job entry has the id, name and status
    Clicking on a job entry takes you to the job details view

Job Creation view (button is placed on the top right of the job listing view)
Job Details view (when clicking on a job, it will redirect you to the details view for that job)
    In this view, you have 3 icons on the top right (comments, activity, photos)
    You see the information about a job and the list of tasks associated with the job
         Each task has a button to the right to complete the task
    On the top left of the details view, there is a button to "Complete Job"
        Completing a job automatically completes all tasks associated  with it
        Completing a job will create a status activity entry for that job (status: "completed")

    Comments view:
    Table view that shows the comments associated with the job. You can add a new comment from here


    Activity view:
    Table view that shows the activity associated with the job. id, status, user, timestamp


    Photos view (nice to have):
    Show photos listing for the associated job. Add a button to the top right to add a new photo (takes you a new view)


    Add new photo view:
