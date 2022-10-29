Unit 11: Group Milestone - README
===

# Job Scheduler

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
The job scheduler app is designed to track, organize, and manage the different jobs assigned to employees. Managers are able to create and assign jobs/tasks to their subordinates, track the status, and view comments about the job. Subordinates are able to view their list of assigned jobs, change the status (assigned, in-progress, completed), and add comments to the job. This app could be used as a means to manage grievances made to companies or as a way to manage software bugs.

### App Evaluation
- **Category:** Business / Productivity
- **Mobile:** This app would be primarily developed for iOS devices.
- **Story:** Create jobs/tasks and assign them to employees. Manage the progress of the job and view any comments made.
- **Market:** Any sized company or group could choose to use this app. People would be organized into roles, either a manager or employee, to better handle job assignments and completion.
- **Habit:** This app could be used on a daily basis to manage the jobs assigned and ensure jobs are being completed in a timely manner.
- **Scope:** First we would start with the job scheduling features and then perhaps expand the app to include communication between other employees and departments. This app is intended for small companies or groups of people not wanting to use bigger solutions like Jira, Clickup, etc, looking to better manage and organize job assignments.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User registers as a manager

* User registers as an employee

* User manager logs in and sees the list of jobs.

* User manager clicks on the create job button and creates a job from the create job view. Manager must be able to select a job name, add tasks, and add an assignee. Adding an assignee at this point is optional. The status of the job will be assigned automatically when selecting an assignee. The possible status of a job are: “created”, “assigned”, “in-progress”, and “completed”. 

* User manager clicks on a job from the job listing and gets redirected to the job details view. User is able to see the detailed information about a job

* User manager clicks on a job from the job listing and gets redirected to the job details view. Manager is able to re-assign the job to a different employee.

* User manager clicks on a job from the job listing and gets redirected to the job details view. Manager is able to un-assign the job.

* User clicks on the comments icon from the job detail view, and gets redirected to the comments view. As a manager, I want to be able to add comments to a job after the time of creating it, so that I can keep up to date on the job and ask for progress reports. As an employee, they need to be able to reply to these comments and provide feedback to newly posted comments on the job.

* User clicks on the activity icon from the job detail view, and gets redirected to the activity view. User is able to see the list of status activities for that job.

* User employee logs in and sees the list of jobs assigned to him/her. An employee can only see jobs assigned to him/her.

* User employee clicks on a job from the job listing and gets redirected to the job details view. User can complete or set an in-progress individual tasks and or complete the whole job by clicking the corresponding buttons. Once a job is completed, it won’t be visible in the job listing for that user. A task should have an identity such as having an id, name, and status so that both employees and managers can view the state of a task and know which job it is correlated with. As an employee, I want to be able to change the status of the tasks in each job so that I can report the progress of the overall job.


**Optional Nice-to-have Stories**

* User can request for more jobs to be assigned
* User can request for a job reassignment
* User can view their profile
* User manager can cancel a job
* As an employee, I want to be able to add photos to a completed job to show proof of completion so that the manager can see the completed job

### 2. Screen Archetypes

* Login Screen - User logs in
    * User is forced to login upon opening the app unless he/she is already logged in. The user is presented with a username and password text fields, and two buttons: login and sign up 

* Register Screen - User signs up
   * Upon clicking the sign up button in the login screen, the user will be redirected to the register view, where he/she will be presented with a username and password text fields, and a dropdown to select their access level: manager or employee, and a register button.

* Job List Screen - Chat for users to communicate (direct 1-on-1)
   * A view where we can filter the jobs on the screen based on id, status, employees, and timestamps. Each job in this table would just show the job name, and who it is assigned to (maybe more). From here, if we click on a job, we should be directed to Job details view.

* Job Creation Screen 
   * Only accessible to managers. Allows manager to create a job

* Job Details Screen 
   * The default view when clicking on a job in the jobs view. It presents information about a job
like name, date assigned, tasks list. Users can complete a task and or a job from this view. This screen contains icons for comments, activity, and photos.

* Job Comments Screen
   * A view to show and add comments on a specific job. Can be reached from JobView. Allows users to see the list of comments for a particular job. Users have the ability to add a new comment as well.

* Job Activity Screen
   * READ ONLY VIEW. Allows users to see the status activity for a particular job. For example, when the job was assigned, set as in-progress, and completed.

* Job Photos Screen
   * Allows users to see the list of photos for a particular job. Users have the ability to upload a new photo for said job.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Jobs (Home)
* Logout

Optional:
* Instead of having a logout link in the tab navigation, if time allows we could have a profile link
  where the user can can logout but also have a link to see their profile view

**Flow Navigation** (Screen to Screen)

Manager
* Forced Log-in -> Account creation if no login is available
* User Registration Screen -> Home (Jobs view)
* Jobs View -> Job Creation Screen
* Jobs View -> Job Details view
* Job Details View -> Job Comments view
* Job Details View -> Job Activity View
* Job Details View -> Job Photos View
Employee
* Forced Log-in -> Account creation if no login is available
* User Registration Screen -> Home (Jobs view)
* Jobs View -> Job Creation Screen
* Jobs View -> Job Details view
* Job Details View -> Job Comments view
* Job Details View -> Job Activity View
* Job Details View -> Job Photos View


## Wireframes
<img src="https://i.imgur.com/b9r5YGN.png" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/b9r5YGN.png" width=600>

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

