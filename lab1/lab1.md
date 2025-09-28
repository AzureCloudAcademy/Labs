
**Prerequisites**
1. Create outlook account

https://www.microsoft.com/en-us/microsoft-365/outlook/email-and-calendar-software-microsoft-outlook?deeplink=%2fowa%2f&sdf=0 

2. Create Azure Accounts 
https://azure.microsoft.com/en-us/ 

https://portal.azure.com/#allservices/category/All 

3. Azure DevOps
https://aex.dev.azure.com/me?mkt=en-US 
https://dev.azure.com/ 
https://dev.azure.com/Gopal-DevOps2025-July/ 

 4. Create GitHub Accounts 
https://github.com/ 


# Instructions to create an Azure DevOps Organization (you only have to do this once)

> **Note**: Start at step 3, if you do already have a **personal Microsoft Account** setup and an active Azure Subscription linked to that account.

1. Use a private browser session to get a new **personal Microsoft Account (MSA)** at `https://account.microsoft.com`.

1. Using the same browser session, sign up for a free Azure subscription at `https://azure.microsoft.com/free`.

1. Open a browser and navigate to Azure portal at `https://portal.azure.com`, then search at the top of the Azure portal screen for **Azure DevOps**. In the resulting page, click **Azure DevOps organizations**.

1. Next, click on the link labelled **My Azure DevOps Organizations** or navigate directly to `https://aex.dev.azure.com`.

1. On the **We need a few more details** page, select **Continue**.

1. In the drop-down box on the left, choose **Default Directory**, instead of **Microsoft Account**.

1. If prompted (_"We need a few more details"_), provide your name, e-mail address, and location and click **Continue**.

1. Back at `https://aex.dev.azure.com` with **Default Directory** selected click the blue button **Create new organization**.

1. Accept the _Terms of Service_ by clicking **Continue**.

1. If prompted (_"Almost done"_), leave the name for the Azure DevOps organization at default (it needs to be a globally unique name) and pick a hosting location close to you from the list.

1. Once the newly created organization opens in **Azure DevOps**, select **Organization settings** in the bottom left corner.

1. At the **Organization settings** screen select **Billing** (opening this screen takes a few seconds).

1. Select **Setup billing** and on the right-hand side of the screen, select your **Azure Subscription** and then select **Save** to link the subscription with the organization.

1. Once the screen shows the linked Azure Subscription ID at the top, change the number of **Paid parallel jobs** for **MS Hosted CI/CD** from 0 to **1**. Then select **SAVE** button at the bottom.

   > **Note**: You may **wait a couple of minutes before using the CI/CD capabilities** so that the new settings are reflected in the backend. Otherwise, you will still see the message _"No hosted parallelism has been purchased or granted"_.

1. In **Organization Settings**, go to section **Pipelines** and click **Settings**.

1. Toggle the switch to **Off** for **Disable creation of classic build pipelines** and **Disable creation of classic release pipelines**

   > **Note**: The **Disable creation of classic release pipelines** switch sets to **On** hides classic release pipeline creation options such as the **Release** menu in the **Pipeline** section of DevOps projects.

1. In **Organization Settings**, go to section **Security** and click **Policies**.

1. Toggle the switch to **On** for **Allow public projects**
2. 


-----------

Sprint1 2 weeks of the sprint 

Sprint Create 

 🔹 Azure Cloud Academy – Sample Sprint Plan
1. Why do we use Sprints?

Agile teams work in short, time-boxed iterations (called sprints) instead of long project cycles.

Each sprint delivers a working increment (something usable & testable).

Helps with predictability, focus, and continuous improvement.

👉 Key Benefit: “Instead of waiting 6 months for results, we deliver value every 2 weeks.”

2. Sprint Duration (Best Practice)

Most common: 2 weeks (10 working days, Mon–Fri)

Can be 1–4 weeks, depending on project size and team maturity.

Shorter sprints = faster feedback, but more planning overhead.

👉 For learning, we’ll take a 2-week sprint example.

3. Our Sample Sprint (Azure Cloud Academy Demo)

Sprint Name: Sprint 1 – Sep 8 to Sep 19 (2 Weeks)

Start Date: Monday, 8th Sept 2025

End Date: Friday, 19th Sept 2025

Working Days: 10 (Mon–Fri x 2 weeks)

Capacity (per user): 60 hrs (6 productive hrs × 10 days)

4. Sprint Workflow (Day-by-Day Plan)
Day	Activity	Example in Azure Cloud Context
Day 1 (Mon)	Sprint Planning + Requirements	Define story: “Deploy a Web App in Azure with CI/CD pipeline”
Day 2 (Tue)	Analysis & Design	Decide which Azure services (App Service, DevOps pipeline, Storage)
Day 3 (Wed)	Build / Compile	Create Resource Group + Bicep/Terraform infra
Day 4 (Thu)	Unit Testing	Verify infra deployment works
Day 5 (Fri)	Code Review / Analysis	Peer review IaC templates, YAML pipeline
Day 6 (Mon)	Security Scanning	Run tfsec / SonarQube checks
Day 7 (Tue)	Deployment	Deploy App + Pipeline to Azure
Day 8 (Wed)	Testing (Validate Deployment)	Test app functionality + monitor in Azure
Day 9 (Thu)	Bug Fixing + Hardening	Fix pipeline/deployment issues
Day 10 (Fri)	Sign-off + Sprint Review + Retrospective	Demo to class → Collect feedback → Note improvements
5. Key Agile Ceremonies You Can Explain

Sprint Planning (Day 1): Decide what to build.

Daily Scrum (15 min): Quick check-in: Yesterday, Today, Blockers.

Sprint Review (End): Demo the working solution.

Sprint Retrospective (End): Reflect on what went well / improve next sprint.

✅ With this, students see:

Why sprints matter

How many days are used (2 weeks = 10 working days)

What actually happens inside a sprint (task flow + ceremonies)

A real Azure Cloud Example Story to make it practical


# Assignment
🚀 Azure Cloud Academy – Weekly Assignment 🌍

✅ Create your accounts: Outlook, Azure Cloud, Azure DevOps, GitHub
✅ Create an Azure DevOps Organization & Project
✅ Onboard your team at the organization level

📸 Final Task:
Take a screenshot of your setup, create a LinkedIn post, and tag the Azure Cloud Academy page so we can celebrate your progress together 🎉







