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

Presentation {
	id: presentation

	function nextSlide() {
		console.log("QML Component (default slideshow) Next slide");
		presentation.goToNextSlide();
	}
	Timer {
		id: advanceTimer
		interval: 30000
		running: presentation.activatedInCalamares
		repeat: true
		onTriggered: nextSlide()
	}
	Slide {
		anchors.fill: parent
		anchors.verticalCenterOffset: 0
		Image {
			id: background1
			source: "slide-1.png"
			width: parent.width; height: parent.height
			verticalAlignment: Image.AlignTop
			fillMode: Image.PreserveAspectFit
			anchors.fill: parent
		}
		Text {
			anchors.horizontalCenter: background1.horizontalCenter
			anchors.top: background1.bottom
			text: "Arch Linux is now installing on your computer. Go and make a cup of tea because this will take a long time."
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
			source: "slide-2.png"
			width: parent.width; height: parent.height
			verticalAlignment: Image.AlignTop
			fillMode: Image.PreserveAspectFit
			anchors.fill: parent
		}
		Text {
			anchors.horizontalCenter: background2.horizontalCenter
			anchors.top: background2.bottom
			text: "Xfce is a lightweight desktop environment for UNIX-like operating systems. It aims to be fast and low on system resources, while still being visually appealing and user friendly."
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
