main: gui-ncurses.c
	@gcc -o pacshweep-gui gui-ncurses.c -lncurses
  
  #  PREFIX is environment variable, but if it is not set, then set default value
ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

install:
    install -d $(DESTDIR)$(PREFIX)/bin/
    install -d $(DESTDIR)$(HOME)/.config/pacshweep/
    install -m 755 pacswheep $(DESTDIR)$(PREFIX)/bin/
    install -m 755 pacshweep-gui $(DESTDIR)$(PREFIX)/bin/
    install -m 644 pac.conf $(DESTDIR)$(HOME)/.config/pacshweep/
    install -m 644 pacshweep $(DESTDIR)$(PREFIX)/man/man1/
    install -m 644 pacshweep-gui $(DESTDIR)$(PREFIX)/man/man1/

uninstall:
	rm -v $(DESTDIR)$(PREFIX)/bin/pacswheep
	rm -v $(DESTDIR)$(PREFIX)/bin/pacswheep-gui
	rm -Rfv $(DESTDIR)$(HOME)/.config/pacshweep/
	rm -v $(DESTDIR)$(PREFIX)/man/man1/pacshweep
	rm -v $(DESTDIR)$(PREFIX)/man/man1/pacswheep-gui
	rm $(DESTDIR)/tmp/*.pacshweep
