import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: root
    visible: true
    minimumWidth: 500
    minimumHeight: 500
    width: 540
    height: 960
    Material.theme: Material.Light
    Material.accent: Material.Cyan


    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: signInPage
    }
    Page {
        id: signInPage

        header: ToolBar {
            ToolButton {
                   text: qsTr("Exit")
                   anchors.left: parent.left
                   anchors.leftMargin: 10
                   anchors.verticalCenter: parent.verticalCenter
                   onClicked: close()
               }
            ToolButton {
                   text: qsTr("About")
                   anchors.right: parent.right
                   anchors.rightMargin: 10
                   anchors.verticalCenter: parent.verticalCenter
                   onClicked: signInPage.StackView.view.push("qrc:/AboutPage.qml")
               }
            Material.background: Material.Cyan
            Label {
                text: qsTr("LogIn")
                font.pixelSize: 20
                anchors.centerIn: parent
            }
        }
        Column {
            anchors.centerIn: parent
            width: parent.width - 50
            height: parent.height-150;

            TextField {

                           id: username
                           Layout.fillWidth: true
                           width: parent.width
                           placeholderText: qsTr("Email")
                           onFocusChanged:  {
                               wrong.visible = false
                           }
                       }

                       TextField {
                           id: password
                           echoMode: TextInput.Password
                           Layout.fillWidth: true
                           width: parent.width
                           placeholderText: qsTr("Password")
                           onFocusChanged: {
                               wrong.visible = false
                           }
                       }

            Button {
                contentItem: Text {
                       text: parent.text
                       font: parent.font
                       opacity: enabled ? 1.0 : 0.3
                       color: "white"
                       horizontalAlignment: Text.AlignHCenter
                       verticalAlignment: Text.AlignVCenter
                       elide: Text.ElideRight
                   }
                 id: signIn
                 width: parent.width
                 text: qsTr("Log In")

                 Material.background: Material.Teal// Change the background
                 onClicked: {
                     var userid = serviceAccessor.tryLogIn(username.text,password.text)
                     console.log(userid)
                     //var userid = 1
                     if(userid === 0){
                         wrong.visible = true
                         return
                     }
                     var userRights = serviceAccessor.getUserRights(userid)
                     console.log(userRights)
                     //var userRights = "admin"
                     if(userRights === "admin"){
                         signInPage.StackView.view.push("qrc:/CustmoerMainPage.qml", {customerId : userid})
                         console.log(userid)
                         return
                     }
                     if(userRights === "user"){
                         signInPage.StackView.view.push("qrc:/EmployeeMainPage.qml", {userId: userid})
                         return
                     }
                     console.log(userRights)
                 }
             }

            Button {
                contentItem: Text {
                       text: parent.text
                       font: parent.font
                       opacity: enabled ? 1.0 : 0.3
                       color: "white"
                       horizontalAlignment: Text.AlignHCenter
                       verticalAlignment: Text.AlignVCenter
                       elide: Text.ElideRight
                   }

                 id: signUp
                 width: parent.width
                 text: qsTr("Register")

                 Material.background: Material.Teal // Change the background
                 onClicked: {
                     signInPage.StackView.view.push("qrc:/RegistrationPage.qml",{})
                 }
             }
            Text {
                visible: false
                id: wrong
                color: "red"
                text: qsTr("Wrong username or password.")
            }
        }
    }
}


