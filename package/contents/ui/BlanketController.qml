import QtQml
import org.kde.plasma.private.kicker as Kicker
import org.kde.plasma.workspace.dbus as DBus

QtObject {
    readonly property bool running: serviceWatcher.registered

    readonly property DBus.DBusServiceWatcher serviceWatcher: DBus.DBusServiceWatcher {
        busType: DBus.BusType.Session
        watchedService: "com.rafaelmardojai.Blanket"
    }

    // Desktop-entry activation lets Blanket present its existing window.
    readonly property Kicker.SimpleFavoritesModel launcher: Kicker.SimpleFavoritesModel {
        favorites: ["com.rafaelmardojai.Blanket.desktop"]
    }

    readonly property DBus.dbusMessage quitMessage: ({
        service: "com.rafaelmardojai.Blanket",
        path: "/com/rafaelmardojai/Blanket",
        iface: "org.gtk.Actions",
        member: "Activate",
        signature: "(sava{sv})",
        arguments: ["quit", [], {}]
    })

    function open() {
        if (!launcher.trigger(0, "", null)) {
            console.warn("Could not launch Blanket. Check that Blanket is installed.");
        }
    }

    function quit() {
        if (!running) {
            return;
        }

        DBus.SessionBus.asyncCall(quitMessage, () => {}, reply => {
            console.warn("Could not quit Blanket:", reply.error.message);
        });
    }
}
