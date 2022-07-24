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
    install -m 644 pacshweep $(PREFIX)/man/man1/
    install -m 644 pacshweep-gui $(PREFIX)/man/man1/
