/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2015 Teo Mrnjavac <teo@kde.org>
 *   SPDX-FileCopyrightText: 2018 Adriaan de Groot <groot@kde.org>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation
    function nextSlide() {
        console.log("QML Component (default slideshow) Next slide");
        presentation.goToNextSlide();
    }
    Timer {
        id: advanceTimer
        interval: 20000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    Slide {
    anchors.fill: parent
    anchors.verticalCenterOffset: 0
    Image {
        id: background1
        source: "slide-01.png"
        width: parent.width; height: parent.height
        verticalAlignment: Image.AlignTop
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
    	}
    Text {
        anchors.horizontalCenter: background1.horizontalCenter
        anchors.top: background1.bottom
        text: "Welcome to Arch Linux, a lightweight and flexible Linux distribution that tries to Keep It Simple."
        wrapMode: Text.WordWrap
        width: presentation.width
        horizontalAlignment: Text.Center
    	}
    }

    Slide {
    anchors.fill: parent
    anchors.verticalCenterOffset: 0
    Image {
        id: background2
        source: "slide-02.png"
        width: parent.width; height: parent.height
        verticalAlignment: Image.AlignTop
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
    	}
    Text {
        anchors.horizontalCenter: background2.horizontalCenter
        anchors.top: background2.bottom
        text: "XFCE is a lightweight desktop environment. It aims to be fast and low on system resources, while still being visually appealing and user friendly."
        wrapMode: Text.WordWrap
        width: presentation.width
        horizontalAlignment: Text.Center
    	}
    }

    Slide {
        anchors.fill: parent
        anchors.verticalCenterOffset: 0
        Image {
            id: background3
            source: "slide-03.png"
            width: parent.width; height: parent.height
            verticalAlignment: Image.AlignTop
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }
        Text {
            anchors.horizontalCenter: background3.horizontalCenter
            anchors.top: background3.bottom
            text: "Octopi is the highest rated graphical package manager for Arch Linux. You can search, install, remove, and upgrade packages from main and foreign repositories as well as the Arch User Repository (AUR), visualize their files and view repository changes and distribution news."
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    Slide {
        anchors.fill: parent
        anchors.verticalCenterOffset: 0
        Image {
            id: background4
            source: "slide-04.png"
            width: parent.width; height: parent.height
            verticalAlignment: Image.AlignTop
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }
        Text {
            anchors.horizontalCenter: background4.horizontalCenter
            anchors.top: background4.bottom
            text: "Installation is almost finished. We appreciate your patience and hope you enjoy using Arch Linux!"
            wrapMode: Text.WordWrap
            width: presentation.width
            horizontalAlignment: Text.Center
        }
    }

    // When this slideshow is loaded as a V1 slideshow, only
    // activatedInCalamares is set, which starts the timer (see above).
    //
    // In V2, also the onActivate() and onLeave() methods are called.
    // These example functions log a message (and re-start the slides
    // from the first).
    function onActivate() {
        console.log("QML Component (default slideshow) activated");
        presentation.currentSlide = 0;
    }
    function onLeave() {
        console.log("QML Component (default slideshow) deactivated");
    }

}
