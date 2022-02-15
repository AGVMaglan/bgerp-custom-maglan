package org.bgerp.plugin.custom.maglan;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import ru.bgcrm.event.EventProcessor;
import ru.bgcrm.event.ParamChangedEvent;
import ru.bgcrm.plugin.Endpoint;

/**
 * BGERP Custom Maglan Plugin.
 */
public class Plugin extends ru.bgcrm.plugin.Plugin {
    public static final String ID = "custom.maglan";

    public Plugin() {
        super(ID);
    }

    /*
        No logic so far.
    */
}
