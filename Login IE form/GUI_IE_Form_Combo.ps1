# --------------------------------------------------------------------------------------
# Script: GUI_IE_Form_Combo.ps1
# Script Version: v1.0
# Author: Ingo Bechtle
# comments: opens a username/password form and navigates to a internet page for credential entry
# --------------------------------------------------------------------------------------

# Load Winforms object
[reflection.assembly]::LoadWithPartialName( "System.Windows.Forms")

# Form has been created here
$form = New-Object Windows.Forms.Form
$form.StartPosition = "CenterScreen"

# My dialog title
$form.text = "Login Form"

# Set a label control and set text, size and location
$label = New-Object Windows.Forms.Label
$label.Location = New-Object Drawing.Point 50,30
$label.Size = New-Object Drawing.Point 200,15
$label.text = "Please enter your password"

# Setting up a TextBox and set text, size and location
$textfield = New-Object Windows.Forms.MaskedTextBox
$textfield.PasswordChar = "*"
$textfield.Location = New-Object Drawing.Point 50,60
$textfield.Size = New-Object Drawing.Point 200,30

# Set a button and set text and location
$button = New-Object Windows.Forms.Button
$button.text = "Enter"
$button.Location = New-Object Drawing.Point 100,90

# Opens the Login and entering the form
# Please notice to set the elements according to their names in HTML
$button.add_click({
$ie = new-object -com InternetExplorer.Application
$ie.navigate("https://enter_your_internet_adress_that_has_a_login_form")
$ie.visible = $true
while($ie.busy){start-sleep 1}
# Username
$ie.Document.getElementByID("username").value = "YOUR_USERNAME"
# Just an example for another field
$ie.Document.getElementByID("realm").value = "DOMAIN_FOR_EXAMPLE"
# Password
$ie.Document.getElementByID("password").value = $textfield.Text
while($ie.busy){start-sleep 1}
# Click the submit button
$ie.Document.getElementByID("btnSubmit").Click()
while($ie.busy){start-sleep 1}
})

# Controls are being added here
$form.controls.add($button)
$form.controls.add($label)
$form.controls.add($textfield)

# Show the dialog
$form.ShowDialog()
