import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.private.kicker as Kicker

PlasmoidItem {
    id: root

    Plasmoid.icon: "com.rafaelmardojai.Blanket"
    Plasmoid.status: PlasmaCore.Types.ActiveStatus
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    toolTipMainText: i18n("Blanket")
    toolTipSubText: i18n("Open Blanket")
    preferredRepresentation: compactRepresentation

    // Use Plasma's application launcher to preserve desktop-entry activation.
    // Blanket forwards activation to its existing window when already running.
    Kicker.SimpleFavoritesModel {
        id: launcher
        favorites: ["com.rafaelmardojai.Blanket.desktop"]
    }

    function openBlanket() {
        if (!launcher.trigger(0, "", null)) {
            console.warn("Could not launch Blanket. Check that Blanket is installed.");
        }
    }

    onActivated: openBlanket()

    compactRepresentation: MouseArea {
        acceptedButtons: Qt.LeftButton
        onClicked: root.openBlanket()

        Kirigami.Icon {
            anchors.fill: parent
            source: root.Plasmoid.icon
            active: parent.containsMouse
        }

        hoverEnabled: true
    }
}
