version-1



import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 450
    title: "WiFi Manager"

    property bool wifiOn: wifi.wifiOn
    property bool wifiConnected: false
    property string connectedSSID: ""
    property string ipAddr: ""
    property bool showWifiList: false
    property string selectedSSID: ""

    Timer {
        interval: 1500
        running: true
        repeat: true
        onTriggered: {
            wifiConnected = wifi.connected
            connectedSSID = wifi.getConnectedSSID()
            ipAddr = wifi.getIpAddress()
        }
    }

    Column {
        anchors.fill: parent
        spacing: 12
        padding: 20

        // Title
        Text {
            text: "WiFi Manager"
            font.pixelSize: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // WiFi status
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                width: 16
                height: 16
                radius: 8
                color: !wifiOn ? "gray" : (wifiConnected ? "green" : "red")
            }

            Text {
                text: !wifiOn
                      ? "WiFi Off"
                      : (wifiConnected ? "Connected to " + connectedSSID + " (" + ipAddr + ")" : "Disconnected")
                color: wifiConnected ? "green" : "red"
            }
        }

        // WiFi toggle
        Row {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter

            Text { text: "WiFi:" }

            Switch {
                checked: wifiOn
                onToggled: {
                    wifiOn = checked
                    wifi.wifiOn = checked
                    if (!checked) showWifiList = false
                }
            }
        }

        // Show WiFi list button
        Button {
            text: showWifiList ? "Hide WiFi List" : "Show WiFi List"
            width: 240
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                showWifiList = !showWifiList
                if (showWifiList) wifi.scanWifi()
            }
        }

        // WiFi list view
        Rectangle {
            width: parent.width - 40
            height: showWifiList ? 180 : 0
            Behavior on height { NumberAnimation { duration: 150 } }
            color: "white"
            radius: 10
            border.color: "#ccc"
            visible: showWifiList
            clip: true

            ListView {
                id: wifiListView
                anchors.fill: parent
                model: ListModel {}

                delegate: Rectangle {
                    width: parent.width
                    height: 44
                    color: "#f5f5f5"
                    border.color: "#ccc"
                    radius: 6

                    Row {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Text { text: name; width: parent.width * 0.8 }

                        Rectangle {
                            width: 12; height: 12; radius: 6
                            color: name === connectedSSID ? "green" : "transparent"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            selectedSSID = name
                            passField.text = ""
                            pwdPopup.open()
                        }
                    }
                }
            }
        }
    }

    // Password Popup
    Dialog {
        id: pwdPopup
        modal: true
        title: "Connect to " + selectedSSID
        standardButtons: Dialog.Ok | Dialog.Cancel

        Column {
            spacing: 10; padding: 20

            TextField {
                id: passField
                placeholderText: "Password"
                echoMode: TextInput.Password
                width: 240
            }
        }

        onAccepted: {
            wifi.connectToWifi(selectedSSID, passField.text)
            showWifiList = !showWifiList
                if (showWifiList) wifi.scanWifi()
        }
    }

    // Handle scan results
    Connections {
        target: wifi
        onWifiScanCompleted: function(list){
            wifiListView.model.clear()
            for (var i = 0; i < list.length; i++)
                wifiListView.model.append({ name: list[i] })
        }
    }
}




version - 2

import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 450
    title: "WiFi Manager"
    color: "#87CEEB" // Light sky blue background

    property bool wifiOn: wifi.wifiOn
    property bool wifiConnected: false
    property string connectedSSID: ""
    property string ipAddr: ""
    property bool showWifiList: false
    property string selectedSSID: ""

    Timer {
        interval: 1500
        running: true
        repeat: true
        onTriggered: {
            wifiConnected = wifi.connected
            connectedSSID = wifi.getConnectedSSID()
            ipAddr = wifi.getIpAddress()
        }
    }

    Column {
        anchors.fill: parent
        spacing: 12
        padding: 20

        // Title
        Text {
            text: "WiFi Manager"
            font.pixelSize: 30
            font.bold: true // Make the title bold
            color: "#333" // Dark color for contrast
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // WiFi status
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                width: 16
                height: 16
                radius: 8
                color: !wifiOn ? "gray" : (wifiConnected ? "green" : "red")
            }

            Text {
                text: !wifiOn
                      ? "WiFi Off"
                      : (wifiConnected ? "Connected to " + connectedSSID + " (" + ipAddr + ")" : "Disconnected")
                color: wifiConnected ? "green" : "red"
                font.bold: true // Make the status text bold
            }
        }

        // WiFi toggle
        Row {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter

            Text { 
                text: "WiFi:"
                font.bold: true // Make the WiFi label bold
                color: "#333" // Dark text for contrast
            }

            Switch {
                checked: wifiOn
                onToggled: {
                    wifiOn = checked
                    wifi.wifiOn = checked
                    if (!checked) showWifiList = false
                }
            }
        }

        // Show WiFi list button
        Button {
            text: showWifiList ? "Hide WiFi List" : "Show WiFi List"
            width: 240
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true // Make button text bold
            background: Rectangle {
                color: "#4CAF50" // Green button
                radius: 10
            }
            onClicked: {
                showWifiList = !showWifiList
                if (showWifiList) {
                    wifi.scanWifi()  // Trigger Wi-Fi scan
                    console.log("WiFi scan triggered.")
                }
            }
        }

        // WiFi list view
        Rectangle {
            width: parent.width - 40
            height: showWifiList ? 220 : 0
            Behavior on height { NumberAnimation { duration: 150 } }
            color: "white"
            radius: 10
            border.color: "#ccc"
            visible: showWifiList
            clip: true

            ListView {
                id: wifiListView
                anchors.fill: parent
                model: ListModel {}

                delegate: Rectangle {
                    width: parent.width
                    height: 44
                    color: "#f5f5f5"
                    border.color: "#ccc"
                    radius: 6

                    Row {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Text { 
                            text: name
                            width: parent.width * 0.8
                            font.bold: true // Make SSID name bold
                            color: "#333" // Dark color for better visibility
                        }

                        Rectangle {
                            width: 12; height: 12; radius: 6
                            color: name === connectedSSID ? "green" : "transparent"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            selectedSSID = name
                            passField.text = ""
                            pwdPopup.open()
                        }
                    }
                }
            }
        }
    }

    // Password Popup
    Dialog {
        id: pwdPopup
        modal: true
        title: "Connect to " + selectedSSID
        standardButtons: Dialog.Ok | Dialog.Cancel

        Column {
            spacing: 10; padding: 20

            TextField {
                id: passField
                placeholderText: "Password"
                echoMode: TextInput.Password
                width: 240
                font.bold: true // Make the input text bold
                color: "#333" // Dark text for contrast
            }
        }

        onAccepted: {
            wifi.connectToWifi(selectedSSID, passField.text)
            showWifiList = !showWifiList
            if (showWifiList) wifi.scanWifi()
        }
    }

    // Handle scan results
    Connections {
        target: wifi
        onWifiScanCompleted: function(list){
            console.log("WiFi scan completed. Number of networks: " + list.length)
            wifiListView.model.clear()
            for (var i = 0; i < list.length; i++) {
                console.log("Network found: " + list[i])  // Log each network found
                wifiListView.model.append({ name: list[i] })
            }
        }
    }
}

