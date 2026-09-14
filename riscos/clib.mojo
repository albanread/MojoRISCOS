"""The C library surface — generated from clib.json by
    tools/clibspec/gen_mojo.py.  Do not edit; regenerate.

Every wrapper calls the ROM's SharedCLibrary through the
roclib veneers (registered by roclib_init/roclib_run in
rostrt).  Mojo code uses these instead of SWIs so it stays
portable across RISC OS versions: the binding is rebuilt,
not the programs.
"""

from std.ffi import external_call

# ========================================================================
# The portable surface: scalar/pointer prototypes whose
# AAPCS and APCS-32 layouts coincide (clib.json class
# `identical`).  Float, variadic and struct-by-value C
# functions are implemented locally in rostrt and are not
# bound here.
# ========================================================================

def isblank(arg0: Int32) -> Int32:
    """isblank — ctype, via the SharedCLibrary."""
    return external_call["isblank", Int32](arg0)

def tolower(arg0: Int32) -> Int32:
    """tolower — ctype, via the SharedCLibrary."""
    return external_call["tolower", Int32](arg0)

def toupper(arg0: Int32) -> Int32:
    """toupper — ctype, via the SharedCLibrary."""
    return external_call["toupper", Int32](arg0)

def _kernel_current_stack_chunk() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_kernel_current_stack_chunk — kernel, via the SharedCLibrary."""
    return external_call["_kernel_current_stack_chunk", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def _kernel_exit(arg0: Int32) -> Int32:
    """_kernel_exit — kernel, via the SharedCLibrary."""
    return external_call["_kernel_exit", Int32](arg0)

def _kernel_raise_error(_kernel_oserror: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """_kernel_raise_error — kernel, via the SharedCLibrary."""
    return external_call["_kernel_raise_error", Int32](_kernel_oserror)

def _kernel_exittraphandler() -> Int32:
    """_kernel_exittraphandler — kernel, via the SharedCLibrary."""
    return external_call["_kernel_exittraphandler", Int32]()

def _kernel_hostos() -> Int32:
    """_kernel_hostos — kernel, via the SharedCLibrary."""
    return external_call["_kernel_hostos", Int32]()

def _kernel_fpavailable() -> Int32:
    """_kernel_fpavailable — kernel, via the SharedCLibrary."""
    return external_call["_kernel_fpavailable", Int32]()

def _kernel_command_string() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_kernel_command_string — kernel, via the SharedCLibrary."""
    return external_call["_kernel_command_string", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def _kernel_osrdch() -> Int32:
    """_kernel_osrdch — kernel, via the SharedCLibrary."""
    return external_call["_kernel_osrdch", Int32]()

def _kernel_oscli(s: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """_kernel_oscli — kernel, via the SharedCLibrary."""
    return external_call["_kernel_oscli", Int32](s)

def _kernel_last_oserror() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_kernel_last_oserror — kernel, via the SharedCLibrary."""
    return external_call["_kernel_last_oserror", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def _kernel_setenv(name: UnsafePointer[UInt8, MutUntrackedOrigin], value: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_kernel_setenv — kernel, via the SharedCLibrary."""
    return external_call["_kernel_setenv", UnsafePointer[UInt8, MutUntrackedOrigin]](name, value)

def _kernel_register_allocs(malloc: UnsafePointer[UInt8, MutUntrackedOrigin], free: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """_kernel_register_allocs — kernel, via the SharedCLibrary."""
    return external_call["_kernel_register_allocs", Int32](malloc, free)

def __rt_allocauto(arg0: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """__rt_allocauto — kernel, via the SharedCLibrary."""
    return external_call["__rt_allocauto", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def __rt_freeauto(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """__rt_freeauto — kernel, via the SharedCLibrary."""
    return external_call["__rt_freeauto", Int32](arg0)

def _kernel_register_slotextend(proc: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_kernel_register_slotextend — kernel, via the SharedCLibrary."""
    return external_call["_kernel_register_slotextend", UnsafePointer[UInt8, MutUntrackedOrigin]](proc)

def _kernel_escape_seen() -> Int32:
    """_kernel_escape_seen — kernel, via the SharedCLibrary."""
    return external_call["_kernel_escape_seen", Int32]()

def _kernel_unwind(inout: UnsafePointer[UInt8, MutUntrackedOrigin], language: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """_kernel_unwind — kernel, via the SharedCLibrary."""
    return external_call["_kernel_unwind", Int32](inout, language)

def _kernel_client_is_module() -> Int32:
    """_kernel_client_is_module — kernel, via the SharedCLibrary."""
    return external_call["_kernel_client_is_module", Int32]()

def _kernel_processor_mode() -> Int32:
    """_kernel_processor_mode — kernel, via the SharedCLibrary."""
    return external_call["_kernel_processor_mode", Int32]()

def _kernel_irqs_on() -> Int32:
    """_kernel_irqs_on — kernel, via the SharedCLibrary."""
    return external_call["_kernel_irqs_on", Int32]()

def _kernel_irqs_off() -> Int32:
    """_kernel_irqs_off — kernel, via the SharedCLibrary."""
    return external_call["_kernel_irqs_off", Int32]()

def _kernel_irqs_disabled() -> Int32:
    """_kernel_irqs_disabled — kernel, via the SharedCLibrary."""
    return external_call["_kernel_irqs_disabled", Int32]()

def _kernel_RMAfree(p: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """_kernel_RMAfree — kernel, via the SharedCLibrary."""
    return external_call["_kernel_RMAfree", Int32](p)

def setlocale(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """setlocale — locale, via the SharedCLibrary."""
    return external_call["setlocale", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def localeconv() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """localeconv — locale, via the SharedCLibrary."""
    return external_call["localeconv", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def __SIG_DFL(arg0: Int32) -> Int32:
    """__SIG_DFL — signal, via the SharedCLibrary."""
    return external_call["__SIG_DFL", Int32](arg0)

def __SIG_ERR(arg0: Int32) -> Int32:
    """__SIG_ERR — signal, via the SharedCLibrary."""
    return external_call["__SIG_ERR", Int32](arg0)

def __SIG_IGN(arg0: Int32) -> Int32:
    """__SIG_IGN — signal, via the SharedCLibrary."""
    return external_call["__SIG_IGN", Int32](arg0)

def raise(arg0: Int32) -> Int32:
    """raise — signal, via the SharedCLibrary."""
    return external_call["raise", Int32](arg0)

def remove(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """remove — stdio, via the SharedCLibrary."""
    return external_call["remove", Int32](arg0)

def rename(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """rename — stdio, via the SharedCLibrary."""
    return external_call["rename", Int32](arg0, arg1)

def tmpfile() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """tmpfile — stdio, via the SharedCLibrary."""
    return external_call["tmpfile", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def _tmpfile64() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_tmpfile64 — stdio, via the SharedCLibrary."""
    return external_call["_tmpfile64", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def tmpnam(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """tmpnam — stdio, via the SharedCLibrary."""
    return external_call["tmpnam", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def fclose(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """fclose — stdio, via the SharedCLibrary."""
    return external_call["fclose", Int32](arg0)

def fflush(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """fflush — stdio, via the SharedCLibrary."""
    return external_call["fflush", Int32](arg0)

def fopen(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """fopen — stdio, via the SharedCLibrary."""
    return external_call["fopen", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def _fopen64(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_fopen64 — stdio, via the SharedCLibrary."""
    return external_call["_fopen64", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def freopen(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """freopen — stdio, via the SharedCLibrary."""
    return external_call["freopen", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def _freopen64(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_freopen64 — stdio, via the SharedCLibrary."""
    return external_call["_freopen64", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def setbuf(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """setbuf — stdio, via the SharedCLibrary."""
    return external_call["setbuf", Int32](arg0, arg1)

def setvbuf(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, arg3: UInt32) -> Int32:
    """setvbuf — stdio, via the SharedCLibrary."""
    return external_call["setvbuf", Int32](arg0, arg1, arg2, arg3)

def fgetc(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """fgetc — stdio, via the SharedCLibrary."""
    return external_call["fgetc", Int32](arg0)

def fgets(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """fgets — stdio, via the SharedCLibrary."""
    return external_call["fgets", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def fputc(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """fputc — stdio, via the SharedCLibrary."""
    return external_call["fputc", Int32](arg0, arg1)

def fputs(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """fputs — stdio, via the SharedCLibrary."""
    return external_call["fputs", Int32](arg0, arg1)

def __filbuf(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """__filbuf — stdio, via the SharedCLibrary."""
    return external_call["__filbuf", Int32](arg0)

def gets(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """gets — stdio, via the SharedCLibrary."""
    return external_call["gets", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def __flsbuf(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """__flsbuf — stdio, via the SharedCLibrary."""
    return external_call["__flsbuf", Int32](arg0, arg1)

def puts(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """puts — stdio, via the SharedCLibrary."""
    return external_call["puts", Int32](arg0)

def ungetc(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ungetc — stdio, via the SharedCLibrary."""
    return external_call["ungetc", Int32](arg0, arg1)

def fread(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UInt32, arg2: UInt32, arg3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """fread — stdio, via the SharedCLibrary."""
    return external_call["fread", UInt32](arg0, arg1, arg2, arg3)

def fwrite(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UInt32, arg2: UInt32, arg3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """fwrite — stdio, via the SharedCLibrary."""
    return external_call["fwrite", UInt32](arg0, arg1, arg2, arg3)

def fgetpos(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], _off_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """fgetpos — stdio, via the SharedCLibrary."""
    return external_call["fgetpos", Int32](arg0, _off_t)

def _fgetpos64(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], _off64_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """_fgetpos64 — stdio, via the SharedCLibrary."""
    return external_call["_fgetpos64", Int32](arg0, _off64_t)

def fsetpos(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], _off_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """fsetpos — stdio, via the SharedCLibrary."""
    return external_call["fsetpos", Int32](arg0, _off_t)

def _fsetpos64(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], _off64_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """_fsetpos64 — stdio, via the SharedCLibrary."""
    return external_call["_fsetpos64", Int32](arg0, _off64_t)

def rewind(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """rewind — stdio, via the SharedCLibrary."""
    return external_call["rewind", Int32](arg0)

def clearerr(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """clearerr — stdio, via the SharedCLibrary."""
    return external_call["clearerr", Int32](arg0)

def perror(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """perror — stdio, via the SharedCLibrary."""
    return external_call["perror", Int32](arg0)

def atoi(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """atoi — stdlib, via the SharedCLibrary."""
    return external_call["atoi", Int32](arg0)

def rand() -> Int32:
    """rand — stdlib, via the SharedCLibrary."""
    return external_call["rand", Int32]()

def srand(arg0: UInt32) -> Int32:
    """srand — stdlib, via the SharedCLibrary."""
    return external_call["srand", Int32](arg0)

def _ANSI_rand() -> Int32:
    """_ANSI_rand — stdlib, via the SharedCLibrary."""
    return external_call["_ANSI_rand", Int32]()

def _ANSI_srand(arg0: UInt32) -> Int32:
    """_ANSI_srand — stdlib, via the SharedCLibrary."""
    return external_call["_ANSI_srand", Int32](arg0)

def aligned_alloc(arg0: UInt32, arg1: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """aligned_alloc — stdlib, via the SharedCLibrary."""
    return external_call["aligned_alloc", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def calloc(arg0: UInt32, arg1: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """calloc — stdlib, via the SharedCLibrary."""
    return external_call["calloc", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def free(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """free — stdlib, via the SharedCLibrary."""
    return external_call["free", Int32](arg0)

def malloc(arg0: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """malloc — stdlib, via the SharedCLibrary."""
    return external_call["malloc", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def realloc(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """realloc — stdlib, via the SharedCLibrary."""
    return external_call["realloc", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def abort() -> Int32:
    """abort — stdlib, via the SharedCLibrary."""
    return external_call["abort", Int32]()

def exit(arg0: Int32) -> Int32:
    """exit — stdlib, via the SharedCLibrary."""
    return external_call["exit", Int32](arg0)

def quick_exit(arg0: Int32) -> Int32:
    """quick_exit — stdlib, via the SharedCLibrary."""
    return external_call["quick_exit", Int32](arg0)

def _Exit(arg0: Int32) -> Int32:
    """_Exit — stdlib, via the SharedCLibrary."""
    return external_call["_Exit", Int32](arg0)

def getenv(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getenv — stdlib, via the SharedCLibrary."""
    return external_call["getenv", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def system(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """system — stdlib, via the SharedCLibrary."""
    return external_call["system", Int32](arg0)

def abs(arg0: Int32) -> Int32:
    """abs — stdlib, via the SharedCLibrary."""
    return external_call["abs", Int32](arg0)

def mblen(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UInt32) -> Int32:
    """mblen — stdlib, via the SharedCLibrary."""
    return external_call["mblen", Int32](arg0, arg1)

def mbtowc(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> Int32:
    """mbtowc — stdlib, via the SharedCLibrary."""
    return external_call["mbtowc", Int32](wchar_t, arg1, arg2)

def mbstowcs(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UInt32:
    """mbstowcs — stdlib, via the SharedCLibrary."""
    return external_call["mbstowcs", UInt32](wchar_t, arg1, arg2)

def wcstombs(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UInt32:
    """wcstombs — stdlib, via the SharedCLibrary."""
    return external_call["wcstombs", UInt32](arg0, wchar_t, arg2)

def strcpy(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strcpy — string, via the SharedCLibrary."""
    return external_call["strcpy", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def strncpy(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strncpy — string, via the SharedCLibrary."""
    return external_call["strncpy", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def strcat(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strcat — string, via the SharedCLibrary."""
    return external_call["strcat", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def strncat(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strncat — string, via the SharedCLibrary."""
    return external_call["strncat", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def memcmp(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> Int32:
    """memcmp — string, via the SharedCLibrary."""
    return external_call["memcmp", Int32](arg0, arg1, arg2)

def strcmp(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """strcmp — string, via the SharedCLibrary."""
    return external_call["strcmp", Int32](arg0, arg1)

def strncmp(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> Int32:
    """strncmp — string, via the SharedCLibrary."""
    return external_call["strncmp", Int32](arg0, arg1, arg2)

def strcoll(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """strcoll — string, via the SharedCLibrary."""
    return external_call["strcoll", Int32](arg0, arg1)

def strxfrm(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UInt32:
    """strxfrm — string, via the SharedCLibrary."""
    return external_call["strxfrm", UInt32](arg0, arg1, arg2)

def strchr(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strchr — string, via the SharedCLibrary."""
    return external_call["strchr", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def strcspn(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """strcspn — string, via the SharedCLibrary."""
    return external_call["strcspn", UInt32](arg0, arg1)

def strpbrk(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strpbrk — string, via the SharedCLibrary."""
    return external_call["strpbrk", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def strrchr(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strrchr — string, via the SharedCLibrary."""
    return external_call["strrchr", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def strspn(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """strspn — string, via the SharedCLibrary."""
    return external_call["strspn", UInt32](arg0, arg1)

def strstr(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strstr — string, via the SharedCLibrary."""
    return external_call["strstr", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def strtok(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strtok — string, via the SharedCLibrary."""
    return external_call["strtok", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def memcpy(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """memcpy — string, via the SharedCLibrary."""
    return external_call["memcpy", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def memmove(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """memmove — string, via the SharedCLibrary."""
    return external_call["memmove", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def memchr(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """memchr — string, via the SharedCLibrary."""
    return external_call["memchr", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def memset(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """memset — string, via the SharedCLibrary."""
    return external_call["memset", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2)

def strerror(arg0: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strerror — string, via the SharedCLibrary."""
    return external_call["strerror", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def strlen(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """strlen — string, via the SharedCLibrary."""
    return external_call["strlen", UInt32](arg0)

def clock() -> Int32:
    """clock — time, via the SharedCLibrary."""
    return external_call["clock", Int32]()

def mktime(tm: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """mktime — time, via the SharedCLibrary."""
    return external_call["mktime", Int32](tm)

def time(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """time — time, via the SharedCLibrary."""
    return external_call["time", Int32](arg0)

def timespec_get(timespec: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """timespec_get — time, via the SharedCLibrary."""
    return external_call["timespec_get", Int32](timespec, arg1)

def asctime(tm: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """asctime — time, via the SharedCLibrary."""
    return external_call["asctime", UnsafePointer[UInt8, MutUntrackedOrigin]](tm)

def ctime(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """ctime — time, via the SharedCLibrary."""
    return external_call["ctime", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def gmtime(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """gmtime — time, via the SharedCLibrary."""
    return external_call["gmtime", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def localtime(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """localtime — time, via the SharedCLibrary."""
    return external_call["localtime", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def strftime(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UInt32, arg2: UnsafePointer[UInt8, MutUntrackedOrigin], tm: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """strftime — time, via the SharedCLibrary."""
    return external_call["strftime", UInt32](arg0, arg1, arg2, tm)

def fgetwc(__FILE_struct: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """fgetwc — wchar, via the SharedCLibrary."""
    return external_call["fgetwc", UInt32](__FILE_struct)

def fputws(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], __FILE_struct: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """fputws — wchar, via the SharedCLibrary."""
    return external_call["fputws", Int32](wchar_t, __FILE_struct)

def getwc(__FILE_struct: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """getwc — wchar, via the SharedCLibrary."""
    return external_call["getwc", UInt32](__FILE_struct)

def getwchar() -> UInt32:
    """getwchar — wchar, via the SharedCLibrary."""
    return external_call["getwchar", UInt32]()

def ungetwc(wint_t: UInt32, __FILE_struct: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """ungetwc — wchar, via the SharedCLibrary."""
    return external_call["ungetwc", UInt32](wint_t, __FILE_struct)

def fwide(__FILE_struct: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """fwide — wchar, via the SharedCLibrary."""
    return external_call["fwide", Int32](__FILE_struct, arg1)

def wcscpy(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wcscpy — wchar, via the SharedCLibrary."""
    return external_call["wcscpy", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t)

def wcsncpy(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wcsncpy — wchar, via the SharedCLibrary."""
    return external_call["wcsncpy", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t, arg2)

def wmemcpy(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wmemcpy — wchar, via the SharedCLibrary."""
    return external_call["wmemcpy", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t, arg2)

def wmemmove(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wmemmove — wchar, via the SharedCLibrary."""
    return external_call["wmemmove", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t, arg2)

def wcscat(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wcscat — wchar, via the SharedCLibrary."""
    return external_call["wcscat", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t)

def wcsncat(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wcsncat — wchar, via the SharedCLibrary."""
    return external_call["wcsncat", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t, arg2)

def wcscmp(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """wcscmp — wchar, via the SharedCLibrary."""
    return external_call["wcscmp", Int32](wchar_t, wchar_t)

def wcsncmp(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> Int32:
    """wcsncmp — wchar, via the SharedCLibrary."""
    return external_call["wcsncmp", Int32](wchar_t, wchar_t, arg2)

def wcscoll(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """wcscoll — wchar, via the SharedCLibrary."""
    return external_call["wcscoll", Int32](wchar_t, wchar_t)

def wcsxfrm(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UInt32:
    """wcsxfrm — wchar, via the SharedCLibrary."""
    return external_call["wcsxfrm", UInt32](wchar_t, wchar_t, arg2)

def wmemcmp(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> Int32:
    """wmemcmp — wchar, via the SharedCLibrary."""
    return external_call["wmemcmp", Int32](wchar_t, wchar_t, arg2)

def wcscspn(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """wcscspn — wchar, via the SharedCLibrary."""
    return external_call["wcscspn", UInt32](wchar_t, wchar_t)

def wcspbrk(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wcspbrk — wchar, via the SharedCLibrary."""
    return external_call["wcspbrk", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t)

def wcsspn(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """wcsspn — wchar, via the SharedCLibrary."""
    return external_call["wcsspn", UInt32](wchar_t, wchar_t)

def wcsstr(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wcsstr — wchar, via the SharedCLibrary."""
    return external_call["wcsstr", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t)

def wcstok(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """wcstok — wchar, via the SharedCLibrary."""
    return external_call["wcstok", UnsafePointer[UInt8, MutUntrackedOrigin]](wchar_t, wchar_t, wchar_t)

def wcslen(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """wcslen — wchar, via the SharedCLibrary."""
    return external_call["wcslen", UInt32](wchar_t)

def btowc(arg0: Int32) -> UInt32:
    """btowc — wchar, via the SharedCLibrary."""
    return external_call["btowc", UInt32](arg0)

def wctob(wint_t: UInt32) -> Int32:
    """wctob — wchar, via the SharedCLibrary."""
    return external_call["wctob", Int32](wint_t)

def mbsinit(mbstate_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """mbsinit — wchar, via the SharedCLibrary."""
    return external_call["mbsinit", Int32](mbstate_t)

def mbrlen(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UInt32, mbstate_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """mbrlen — wchar, via the SharedCLibrary."""
    return external_call["mbrlen", UInt32](arg0, arg1, mbstate_t)

def mbrtowc(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32, mbstate_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """mbrtowc — wchar, via the SharedCLibrary."""
    return external_call["mbrtowc", UInt32](wchar_t, arg1, arg2, mbstate_t)

def mbsrtowcs(wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32, mbstate_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """mbsrtowcs — wchar, via the SharedCLibrary."""
    return external_call["mbsrtowcs", UInt32](wchar_t, arg1, arg2, mbstate_t)

def wcsrtombs(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], wchar_t: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32, mbstate_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """wcsrtombs — wchar, via the SharedCLibrary."""
    return external_call["wcsrtombs", UInt32](arg0, wchar_t, arg2, mbstate_t)

def iswalnum(wint_t: UInt32) -> Int32:
    """iswalnum — wctype, via the SharedCLibrary."""
    return external_call["iswalnum", Int32](wint_t)

def iswalpha(wint_t: UInt32) -> Int32:
    """iswalpha — wctype, via the SharedCLibrary."""
    return external_call["iswalpha", Int32](wint_t)

def iswblank(wint_t: UInt32) -> Int32:
    """iswblank — wctype, via the SharedCLibrary."""
    return external_call["iswblank", Int32](wint_t)

def iswcntrl(wint_t: UInt32) -> Int32:
    """iswcntrl — wctype, via the SharedCLibrary."""
    return external_call["iswcntrl", Int32](wint_t)

def iswdigit(wint_t: UInt32) -> Int32:
    """iswdigit — wctype, via the SharedCLibrary."""
    return external_call["iswdigit", Int32](wint_t)

def iswgraph(wint_t: UInt32) -> Int32:
    """iswgraph — wctype, via the SharedCLibrary."""
    return external_call["iswgraph", Int32](wint_t)

def iswlower(wint_t: UInt32) -> Int32:
    """iswlower — wctype, via the SharedCLibrary."""
    return external_call["iswlower", Int32](wint_t)

def iswprint(wint_t: UInt32) -> Int32:
    """iswprint — wctype, via the SharedCLibrary."""
    return external_call["iswprint", Int32](wint_t)

def iswpunct(wint_t: UInt32) -> Int32:
    """iswpunct — wctype, via the SharedCLibrary."""
    return external_call["iswpunct", Int32](wint_t)

def iswspace(wint_t: UInt32) -> Int32:
    """iswspace — wctype, via the SharedCLibrary."""
    return external_call["iswspace", Int32](wint_t)

def iswupper(wint_t: UInt32) -> Int32:
    """iswupper — wctype, via the SharedCLibrary."""
    return external_call["iswupper", Int32](wint_t)

def iswxdigit(wint_t: UInt32) -> Int32:
    """iswxdigit — wctype, via the SharedCLibrary."""
    return external_call["iswxdigit", Int32](wint_t)

def towlower(wint_t: UInt32) -> UInt32:
    """towlower — wctype, via the SharedCLibrary."""
    return external_call["towlower", UInt32](wint_t)

def towupper(wint_t: UInt32) -> UInt32:
    """towupper — wctype, via the SharedCLibrary."""
    return external_call["towupper", UInt32](wint_t)

def opendir(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """opendir — tcpip/dirent, via the SharedCLibrary."""
    return external_call["opendir", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def readdir(DIR: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """readdir — tcpip/dirent, via the SharedCLibrary."""
    return external_call["readdir", UnsafePointer[UInt8, MutUntrackedOrigin]](DIR)

def rewinddir(DIR: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """rewinddir — tcpip/dirent, via the SharedCLibrary."""
    return external_call["rewinddir", Int32](DIR)

def closedir(DIR: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """closedir — tcpip/dirent, via the SharedCLibrary."""
    return external_call["closedir", Int32](DIR)

def telldir(DIR: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """telldir — tcpip/dirent, via the SharedCLibrary."""
    return external_call["telldir", Int32](DIR)

def seekdir(DIR: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """seekdir — tcpip/dirent, via the SharedCLibrary."""
    return external_call["seekdir", Int32](DIR, arg1)

def alphasort(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """alphasort — tcpip/dirent, via the SharedCLibrary."""
    return external_call["alphasort", Int32](arg0, arg1)

def getdirentries(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, arg3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """getdirentries — tcpip/dirent, via the SharedCLibrary."""
    return external_call["getdirentries", Int32](arg0, arg1, arg2, arg3)

def err_set_file(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """err_set_file — tcpip/err, via the SharedCLibrary."""
    return external_call["err_set_file", Int32](arg0)

def freeifaddrs(ifaddrs: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """freeifaddrs — tcpip/ifaddrs, via the SharedCLibrary."""
    return external_call["freeifaddrs", Int32](ifaddrs)

def endhostent() -> Int32:
    """endhostent — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["endhostent", Int32]()

def endnetent() -> Int32:
    """endnetent — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["endnetent", Int32]()

def endprotoent() -> Int32:
    """endprotoent — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["endprotoent", Int32]()

def endservent() -> Int32:
    """endservent — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["endservent", Int32]()

def gethostbyname(nam: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """gethostbyname — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["gethostbyname", UnsafePointer[UInt8, MutUntrackedOrigin]](nam)

def gethostent() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """gethostent — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["gethostent", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def getnetbyname(name: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getnetbyname — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["getnetbyname", UnsafePointer[UInt8, MutUntrackedOrigin]](name)

def getnetent() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getnetent — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["getnetent", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def getprotobyname(name: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getprotobyname — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["getprotobyname", UnsafePointer[UInt8, MutUntrackedOrigin]](name)

def getprotoent() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getprotoent — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["getprotoent", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def getservbyname(name: UnsafePointer[UInt8, MutUntrackedOrigin], proto: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getservbyname — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["getservbyname", UnsafePointer[UInt8, MutUntrackedOrigin]](name, proto)

def getservent() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getservent — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["getservent", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def inet_aton(cp: UnsafePointer[UInt8, MutUntrackedOrigin], in: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """inet_aton — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["inet_aton", Int32](cp, in)

def inet_net_ntop(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, arg3: UnsafePointer[UInt8, MutUntrackedOrigin], arg4: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """inet_net_ntop — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["inet_net_ntop", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2, arg3, arg4)

def inet_net_pton(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: UInt32) -> Int32:
    """inet_net_pton — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["inet_net_pton", Int32](arg0, arg1, arg2, arg3)

def inet_ntop(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """inet_ntop — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["inet_ntop", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2, arg3)

def inet_pton(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """inet_pton — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["inet_pton", Int32](arg0, arg1, arg2)

def if_freenameindex(if_nameindex: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """if_freenameindex — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["if_freenameindex", Int32](if_nameindex)

def if_indextoname(arg0: UInt32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """if_indextoname — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["if_indextoname", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def if_nameindex() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """if_nameindex — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["if_nameindex", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def if_nametoindex(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UInt32:
    """if_nametoindex — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["if_nametoindex", UInt32](arg0)

def namisipadr(nam: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """namisipadr — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["namisipadr", UnsafePointer[UInt8, MutUntrackedOrigin]](nam)

def rresvport(alport: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """rresvport — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["rresvport", Int32](alport)

def iso_addr(addr: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """iso_addr — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["iso_addr", UnsafePointer[UInt8, MutUntrackedOrigin]](addr)

def iso_ntoa(isoa: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """iso_ntoa — tcpip/inetlib, via the SharedCLibrary."""
    return external_call["iso_ntoa", UnsafePointer[UInt8, MutUntrackedOrigin]](isoa)

def freehostent(hostent: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """freehostent — tcpip/netdb, via the SharedCLibrary."""
    return external_call["freehostent", Int32](hostent)

def getipnodebyaddr(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UInt32, arg2: Int32, arg3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getipnodebyaddr — tcpip/netdb, via the SharedCLibrary."""
    return external_call["getipnodebyaddr", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2, arg3)

def getipnodebyname(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: Int32, arg3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getipnodebyname — tcpip/netdb, via the SharedCLibrary."""
    return external_call["getipnodebyname", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1, arg2, arg3)

def herror(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """herror — tcpip/netdb, via the SharedCLibrary."""
    return external_call["herror", Int32](arg0)

def hstrerror(arg0: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """hstrerror — tcpip/netdb, via the SharedCLibrary."""
    return external_call["hstrerror", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def getaddrinfo(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], addrinfo: UnsafePointer[UInt8, MutUntrackedOrigin], addrinfo: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """getaddrinfo — tcpip/netdb, via the SharedCLibrary."""
    return external_call["getaddrinfo", Int32](arg0, arg1, addrinfo, addrinfo)

def getnameinfo(sockaddr: UnsafePointer[UInt8, MutUntrackedOrigin], socklen_t: UInt32, arg2: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: UInt32, arg4: UnsafePointer[UInt8, MutUntrackedOrigin], arg5: UInt32, arg6: Int32) -> Int32:
    """getnameinfo — tcpip/netdb, via the SharedCLibrary."""
    return external_call["getnameinfo", Int32](sockaddr, socklen_t, arg2, arg3, arg4, arg5, arg6)

def freeaddrinfo(addrinfo: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """freeaddrinfo — tcpip/netdb, via the SharedCLibrary."""
    return external_call["freeaddrinfo", Int32](addrinfo)

def gai_strerror(arg0: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """gai_strerror — tcpip/netdb, via the SharedCLibrary."""
    return external_call["gai_strerror", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def __fp_resstat(__res_state: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """__fp_resstat — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__fp_resstat", Int32](__res_state, arg1)

def __fp_query(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """__fp_query — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__fp_query", Int32](u_char, arg1)

def __fp_nquery(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """__fp_nquery — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__fp_nquery", Int32](u_char, arg1, arg2)

def __hostalias(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """__hostalias — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__hostalias", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def __p_query(u_char: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """__p_query — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__p_query", Int32](u_char)

def __p_cdnname(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, arg3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """__p_cdnname — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__p_cdnname", UnsafePointer[UInt8, MutUntrackedOrigin]](u_char, u_char, arg2, arg3)

def __p_cdname(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """__p_cdname — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__p_cdname", UnsafePointer[UInt8, MutUntrackedOrigin]](u_char, u_char, arg2)

def __p_fqname(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """__p_fqname — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__p_fqname", UnsafePointer[UInt8, MutUntrackedOrigin]](u_char, u_char, arg2)

def __p_rr(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """__p_rr — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__p_rr", UnsafePointer[UInt8, MutUntrackedOrigin]](u_char, u_char, arg2)

def __p_type(arg0: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """__p_type — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__p_type", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def __p_class(arg0: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """__p_class — tcpip/resolv, via the SharedCLibrary."""
    return external_call["__p_class", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def dn_comp(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """dn_comp — tcpip/resolv, via the SharedCLibrary."""
    return external_call["dn_comp", Int32](arg0, u_char, arg2, u_char, u_char)

def dn_expand(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: UnsafePointer[UInt8, MutUntrackedOrigin], arg4: Int32) -> Int32:
    """dn_expand — tcpip/resolv, via the SharedCLibrary."""
    return external_call["dn_expand", Int32](u_char, u_char, u_char, arg3, arg4)

def res_init() -> Int32:
    """res_init — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_init", Int32]()

def res_query(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: Int32, u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg4: Int32) -> Int32:
    """res_query — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_query", Int32](arg0, arg1, arg2, u_char, arg4)

def res_search(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: Int32, u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg4: Int32) -> Int32:
    """res_search — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_search", Int32](arg0, arg1, arg2, u_char, arg4)

def res_querydomain(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, arg3: Int32, u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg5: Int32) -> Int32:
    """res_querydomain — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_querydomain", Int32](arg0, arg1, arg2, arg3, u_char, arg5)

def res_mkquery(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, arg3: Int32, u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg5: Int32, u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg8: Int32) -> Int32:
    """res_mkquery — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_mkquery", Int32](arg0, arg1, arg2, arg3, u_char, arg5, u_char, u_char, arg8)

def res_send(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, u_char: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: Int32) -> Int32:
    """res_send — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_send", Int32](u_char, arg1, u_char, arg3)

def res_isourserver(sockaddr_in: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """res_isourserver — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_isourserver", Int32](sockaddr_in)

def res_nameinquery(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: Int32, u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """res_nameinquery — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_nameinquery", Int32](arg0, arg1, arg2, u_char, u_char)

def res_queriesmatch(u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin], u_char: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """res_queriesmatch — tcpip/resolv, via the SharedCLibrary."""
    return external_call["res_queriesmatch", Int32](u_char, u_char, u_char, u_char)

def getstablesize() -> Int32:
    """getstablesize — tcpip/socklib, via the SharedCLibrary."""
    return external_call["getstablesize", Int32]()

def kvm_nlist(kd: UnsafePointer[UInt8, MutUntrackedOrigin], nl: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """kvm_nlist — tcpip/socklib, via the SharedCLibrary."""
    return external_call["kvm_nlist", Int32](kd, nl)

def socketversion() -> Int32:
    """socketversion — tcpip/socklib, via the SharedCLibrary."""
    return external_call["socketversion", Int32]()

def _copyerror(e: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """_copyerror — tcpip/socklib, via the SharedCLibrary."""
    return external_call["_copyerror", Int32](e)

def _inet_err() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """_inet_err — tcpip/socklib, via the SharedCLibrary."""
    return external_call["_inet_err", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def chdir(dir: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """chdir — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["chdir", Int32](dir)

def endpwent() -> Int32:
    """endpwent — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["endpwent", Int32]()

def filestat(fname: UnsafePointer[UInt8, MutUntrackedOrigin], type: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """filestat — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["filestat", Int32](fname, type)

def flushinput() -> Int32:
    """flushinput — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["flushinput", Int32]()

def getdtablesize() -> Int32:
    """getdtablesize — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getdtablesize", Int32]()

def getegid() -> UInt32:
    """getegid — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getegid", UInt32]()

def geteuid() -> UInt32:
    """geteuid — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["geteuid", UInt32]()

def getlogin() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getlogin — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getlogin", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def getpass(prompt: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getpass — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getpass", UnsafePointer[UInt8, MutUntrackedOrigin]](prompt)

def getpid() -> Int32:
    """getpid — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getpid", Int32]()

def getpwent() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getpwent — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getpwent", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def getpwnam(name: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getpwnam — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getpwnam", UnsafePointer[UInt8, MutUntrackedOrigin]](name)

def gettimeofday(tv: UnsafePointer[UInt8, MutUntrackedOrigin], tzp: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """gettimeofday — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["gettimeofday", Int32](tv, tzp)

def getuid() -> UInt32:
    """getuid — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getuid", UInt32]()

def getvarhostname() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getvarhostname — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getvarhostname", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def getvarusername() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getvarusername — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getvarusername", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def getwd(buf: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getwd — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["getwd", UnsafePointer[UInt8, MutUntrackedOrigin]](buf)

def killfile(name: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """killfile — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["killfile", Int32](name)

def kvm_close(kd: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """kvm_close — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["kvm_close", Int32](kd)

def kvm_geterr(kd: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """kvm_geterr — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["kvm_geterr", UnsafePointer[UInt8, MutUntrackedOrigin]](kd)

def osreadc() -> Int32:
    """osreadc — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["osreadc", Int32]()

def setpwent() -> Int32:
    """setpwent — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["setpwent", Int32]()

def strcasecmp(a: UnsafePointer[UInt8, MutUntrackedOrigin], b: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """strcasecmp — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["strcasecmp", Int32](a, b)

def strdup(s: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strdup — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["strdup", UnsafePointer[UInt8, MutUntrackedOrigin]](s)

def strsep(stringp: UnsafePointer[UInt8, MutUntrackedOrigin], delim: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """strsep — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["strsep", UnsafePointer[UInt8, MutUntrackedOrigin]](stringp, delim)

def unlink(path: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """unlink — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["unlink", Int32](path)

def xgets(buf: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """xgets — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["xgets", UnsafePointer[UInt8, MutUntrackedOrigin]](buf)

def xperror(s: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """xperror — tcpip/unixlib, via the SharedCLibrary."""
    return external_call["xperror", Int32](s)

def alarm(arg0: UInt32) -> UInt32:
    """alarm — tcpip/unistd, via the SharedCLibrary."""
    return external_call["alarm", UInt32](arg0)

def chown(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], uid_t: UInt32, gid_t: UInt32) -> Int32:
    """chown — tcpip/unistd, via the SharedCLibrary."""
    return external_call["chown", Int32](arg0, uid_t, gid_t)

def confstr(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UInt32) -> UInt32:
    """confstr — tcpip/unistd, via the SharedCLibrary."""
    return external_call["confstr", UInt32](arg0, arg1, arg2)

def dup(arg0: Int32) -> Int32:
    """dup — tcpip/unistd, via the SharedCLibrary."""
    return external_call["dup", Int32](arg0)

def dup2(arg0: Int32, arg1: Int32) -> Int32:
    """dup2 — tcpip/unistd, via the SharedCLibrary."""
    return external_call["dup2", Int32](arg0, arg1)

def execv(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """execv — tcpip/unistd, via the SharedCLibrary."""
    return external_call["execv", Int32](arg0, arg1)

def execve(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """execve — tcpip/unistd, via the SharedCLibrary."""
    return external_call["execve", Int32](arg0, arg1, arg2)

def execvp(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """execvp — tcpip/unistd, via the SharedCLibrary."""
    return external_call["execvp", Int32](arg0, arg1)

def fork() -> Int32:
    """fork — tcpip/unistd, via the SharedCLibrary."""
    return external_call["fork", Int32]()

def fpathconf(arg0: Int32, arg1: Int32) -> Int32:
    """fpathconf — tcpip/unistd, via the SharedCLibrary."""
    return external_call["fpathconf", Int32](arg0, arg1)

def getcwd(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getcwd — tcpip/unistd, via the SharedCLibrary."""
    return external_call["getcwd", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def getgid() -> UInt32:
    """getgid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["getgid", UInt32]()

def getpgrp() -> Int32:
    """getpgrp — tcpip/unistd, via the SharedCLibrary."""
    return external_call["getpgrp", Int32]()

def getppid() -> Int32:
    """getppid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["getppid", Int32]()

def isatty(arg0: Int32) -> Int32:
    """isatty — tcpip/unistd, via the SharedCLibrary."""
    return external_call["isatty", Int32](arg0)

def link(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """link — tcpip/unistd, via the SharedCLibrary."""
    return external_call["link", Int32](arg0, arg1)

def pathconf(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """pathconf — tcpip/unistd, via the SharedCLibrary."""
    return external_call["pathconf", Int32](arg0, arg1)

def pause() -> Int32:
    """pause — tcpip/unistd, via the SharedCLibrary."""
    return external_call["pause", Int32]()

def pipe(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """pipe — tcpip/unistd, via the SharedCLibrary."""
    return external_call["pipe", Int32](arg0)

def rmdir(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """rmdir — tcpip/unistd, via the SharedCLibrary."""
    return external_call["rmdir", Int32](arg0)

def setgid(gid_t: UInt32) -> Int32:
    """setgid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setgid", Int32](gid_t)

def setpgid(pid_t: Int32, pid_t: Int32) -> Int32:
    """setpgid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setpgid", Int32](pid_t, pid_t)

def setsid() -> Int32:
    """setsid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setsid", Int32]()

def setuid(uid_t: UInt32) -> Int32:
    """setuid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setuid", Int32](uid_t)

def sysconf(arg0: Int32) -> Int32:
    """sysconf — tcpip/unistd, via the SharedCLibrary."""
    return external_call["sysconf", Int32](arg0)

def tcgetpgrp(arg0: Int32) -> Int32:
    """tcgetpgrp — tcpip/unistd, via the SharedCLibrary."""
    return external_call["tcgetpgrp", Int32](arg0)

def tcsetpgrp(arg0: Int32, pid_t: Int32) -> Int32:
    """tcsetpgrp — tcpip/unistd, via the SharedCLibrary."""
    return external_call["tcsetpgrp", Int32](arg0, pid_t)

def ttyname(arg0: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """ttyname — tcpip/unistd, via the SharedCLibrary."""
    return external_call["ttyname", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def acct(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """acct — tcpip/unistd, via the SharedCLibrary."""
    return external_call["acct", Int32](arg0)

def async_daemon() -> Int32:
    """async_daemon — tcpip/unistd, via the SharedCLibrary."""
    return external_call["async_daemon", Int32]()

def brk(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """brk — tcpip/unistd, via the SharedCLibrary."""
    return external_call["brk", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def chroot(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """chroot — tcpip/unistd, via the SharedCLibrary."""
    return external_call["chroot", Int32](arg0)

def crypt(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """crypt — tcpip/unistd, via the SharedCLibrary."""
    return external_call["crypt", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0, arg1)

def des_cipher(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32, arg3: Int32) -> Int32:
    """des_cipher — tcpip/unistd, via the SharedCLibrary."""
    return external_call["des_cipher", Int32](arg0, arg1, arg2, arg3)

def des_setkey(key: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """des_setkey — tcpip/unistd, via the SharedCLibrary."""
    return external_call["des_setkey", Int32](key)

def encrypt(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """encrypt — tcpip/unistd, via the SharedCLibrary."""
    return external_call["encrypt", Int32](arg0, arg1)

def endusershell() -> Int32:
    """endusershell — tcpip/unistd, via the SharedCLibrary."""
    return external_call["endusershell", Int32]()

def exect(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """exect — tcpip/unistd, via the SharedCLibrary."""
    return external_call["exect", Int32](arg0, arg1, arg2)

def fchdir(arg0: Int32) -> Int32:
    """fchdir — tcpip/unistd, via the SharedCLibrary."""
    return external_call["fchdir", Int32](arg0)

def fchown(arg0: Int32, uid_t: UInt32, gid_t: UInt32) -> Int32:
    """fchown — tcpip/unistd, via the SharedCLibrary."""
    return external_call["fchown", Int32](arg0, uid_t, gid_t)

def fsync(arg0: Int32) -> Int32:
    """fsync — tcpip/unistd, via the SharedCLibrary."""
    return external_call["fsync", Int32](arg0)

def ftruncate(arg0: Int32, off_t: Int32) -> Int32:
    """ftruncate — tcpip/unistd, via the SharedCLibrary."""
    return external_call["ftruncate", Int32](arg0, off_t)

def getdomainname(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """getdomainname — tcpip/unistd, via the SharedCLibrary."""
    return external_call["getdomainname", Int32](arg0, arg1)

def gethostid() -> Int32:
    """gethostid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["gethostid", Int32]()

def getmode(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], mode_t: UInt32) -> UInt32:
    """getmode — tcpip/unistd, via the SharedCLibrary."""
    return external_call["getmode", UInt32](arg0, mode_t)

def getusershell() -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """getusershell — tcpip/unistd, via the SharedCLibrary."""
    return external_call["getusershell", UnsafePointer[UInt8, MutUntrackedOrigin]]()

def initgroups(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """initgroups — tcpip/unistd, via the SharedCLibrary."""
    return external_call["initgroups", Int32](arg0, arg1)

def iruserok(arg0: UInt32, arg1: Int32, arg2: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """iruserok — tcpip/unistd, via the SharedCLibrary."""
    return external_call["iruserok", Int32](arg0, arg1, arg2, arg3)

def mknod(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], mode_t: UInt32, dev_t: UInt32) -> Int32:
    """mknod — tcpip/unistd, via the SharedCLibrary."""
    return external_call["mknod", Int32](arg0, mode_t, dev_t)

def mkstemp(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """mkstemp — tcpip/unistd, via the SharedCLibrary."""
    return external_call["mkstemp", Int32](arg0)

def mktemp(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """mktemp — tcpip/unistd, via the SharedCLibrary."""
    return external_call["mktemp", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def nfssvc(arg0: Int32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """nfssvc — tcpip/unistd, via the SharedCLibrary."""
    return external_call["nfssvc", Int32](arg0, arg1)

def nice(arg0: Int32) -> Int32:
    """nice — tcpip/unistd, via the SharedCLibrary."""
    return external_call["nice", Int32](arg0)

def psignal(arg0: UInt32, arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """psignal — tcpip/unistd, via the SharedCLibrary."""
    return external_call["psignal", Int32](arg0, arg1)

def profil(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: Int32, arg3: Int32) -> Int32:
    """profil — tcpip/unistd, via the SharedCLibrary."""
    return external_call["profil", Int32](arg0, arg1, arg2, arg3)

def rcmd(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: UnsafePointer[UInt8, MutUntrackedOrigin], arg4: UnsafePointer[UInt8, MutUntrackedOrigin], arg5: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """rcmd — tcpip/unistd, via the SharedCLibrary."""
    return external_call["rcmd", Int32](arg0, arg1, arg2, arg3, arg4, arg5)

def re_comp(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """re_comp — tcpip/unistd, via the SharedCLibrary."""
    return external_call["re_comp", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def re_exec(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """re_exec — tcpip/unistd, via the SharedCLibrary."""
    return external_call["re_exec", Int32](arg0)

def readlink(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin], arg2: Int32) -> Int32:
    """readlink — tcpip/unistd, via the SharedCLibrary."""
    return external_call["readlink", Int32](arg0, arg1, arg2)

def reboot(arg0: Int32) -> Int32:
    """reboot — tcpip/unistd, via the SharedCLibrary."""
    return external_call["reboot", Int32](arg0)

def revoke(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """revoke — tcpip/unistd, via the SharedCLibrary."""
    return external_call["revoke", Int32](arg0)

def ruserok(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32, arg2: UnsafePointer[UInt8, MutUntrackedOrigin], arg3: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """ruserok — tcpip/unistd, via the SharedCLibrary."""
    return external_call["ruserok", Int32](arg0, arg1, arg2, arg3)

def sbrk(arg0: Int32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """sbrk — tcpip/unistd, via the SharedCLibrary."""
    return external_call["sbrk", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def setdomainname(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """setdomainname — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setdomainname", Int32](arg0, arg1)

def setegid(gid_t: UInt32) -> Int32:
    """setegid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setegid", Int32](gid_t)

def seteuid(uid_t: UInt32) -> Int32:
    """seteuid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["seteuid", Int32](uid_t)

def setgroups(arg0: Int32, gid_t: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """setgroups — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setgroups", Int32](arg0, gid_t)

def sethostid(arg0: Int32) -> Int32:
    """sethostid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["sethostid", Int32](arg0)

def sethostname(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: Int32) -> Int32:
    """sethostname — tcpip/unistd, via the SharedCLibrary."""
    return external_call["sethostname", Int32](arg0, arg1)

def setkey(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """setkey — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setkey", Int32](arg0)

def setlogin(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """setlogin — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setlogin", Int32](arg0)

def setmode(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """setmode — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setmode", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def setregid(gid_t: UInt32, gid_t: UInt32) -> Int32:
    """setregid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setregid", Int32](gid_t, gid_t)

def setreuid(uid_t: UInt32, uid_t: UInt32) -> Int32:
    """setreuid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setreuid", Int32](uid_t, uid_t)

def setrgid(gid_t: UInt32) -> Int32:
    """setrgid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setrgid", Int32](gid_t)

def setruid(uid_t: UInt32) -> Int32:
    """setruid — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setruid", Int32](uid_t)

def setusershell() -> Int32:
    """setusershell — tcpip/unistd, via the SharedCLibrary."""
    return external_call["setusershell", Int32]()

def swapon(arg0: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """swapon — tcpip/unistd, via the SharedCLibrary."""
    return external_call["swapon", Int32](arg0)

def symlink(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], arg1: UnsafePointer[UInt8, MutUntrackedOrigin]) -> Int32:
    """symlink — tcpip/unistd, via the SharedCLibrary."""
    return external_call["symlink", Int32](arg0, arg1)

def sync() -> Int32:
    """sync — tcpip/unistd, via the SharedCLibrary."""
    return external_call["sync", Int32]()

def truncate(arg0: UnsafePointer[UInt8, MutUntrackedOrigin], off_t: Int32) -> Int32:
    """truncate — tcpip/unistd, via the SharedCLibrary."""
    return external_call["truncate", Int32](arg0, off_t)

def ttyslot() -> Int32:
    """ttyslot — tcpip/unistd, via the SharedCLibrary."""
    return external_call["ttyslot", Int32]()

def ualarm(arg0: UInt32, arg1: UInt32) -> UInt32:
    """ualarm — tcpip/unistd, via the SharedCLibrary."""
    return external_call["ualarm", UInt32](arg0, arg1)

def usleep(arg0: UInt32) -> Int32:
    """usleep — tcpip/unistd, via the SharedCLibrary."""
    return external_call["usleep", Int32](arg0)

def valloc(arg0: UInt32) -> UnsafePointer[UInt8, MutUntrackedOrigin]:
    """valloc — tcpip/unistd, via the SharedCLibrary."""
    return external_call["valloc", UnsafePointer[UInt8, MutUntrackedOrigin]](arg0)

def vfork() -> Int32:
    """vfork — tcpip/unistd, via the SharedCLibrary."""
    return external_call["vfork", Int32]()


# Deferred to the appendix (function-pointer or exotic
# parameters — bind with `thin abi("C")` types):
#   imaxabs  (intmax_t(intmax_t))
#   imaxdiv  (imaxdiv_t(intmax_t, intmax_t))
#   strtoimax  (intmax_t(const char * restrict, char ** restrict, int))
#   strtoumax  (uintmax_t(const char * restrict, char ** restrict, int))
#   _kernel_setreturncode  (void(unsigned code))
#   _kernel_swi  (_kernel_oserror *(int no, _kernel_swi_regs *in, _kernel_swi_regs *out))
#   _kernel_swi_c  (_kernel_oserror *(int no, _kernel_swi_regs *in, _kernel_swi_regs *out, int *carry))
#   _kernel_osbyte  (int(int op, int x, int y))
#   _kernel_oswrch  (int(int ch))
#   _kernel_osbget  (int(unsigned handle))
#   _kernel_osbput  (int(int ch, unsigned handle))
#   _kernel_osgbpb  (int(int op, unsigned handle, _kernel_osgbpb_block *inout))
#   _kernel_osword  (int(int op, int *data))
#   _kernel_osfind  (int(int op, char *name))
#   _kernel_osfile  (int(int op, const char *name, _kernel_osfile_block *inout))
#   _kernel_osargs  (int(int op, unsigned handle, int arg))
#   _kernel_getenv  (_kernel_oserror *(const char *name, char *buffer, unsigned size))
#   _kernel_system  (int(const char *string, int chain))
#   _kernel_alloc  (unsigned(unsigned minwords, void **block))
#   _kernel_procname  (char *(int pc))
#   _kernel_language  (char *(int pc))
#   _kernel_udiv  (unsigned(unsigned divisor, unsigned dividend))
#   _kernel_urem  (unsigned(unsigned divisor, unsigned dividend))
#   _kernel_udiv10  (unsigned(unsigned dividend))
#   _kernel_sdiv  (int(int divisor, int dividend))
#   _kernel_srem  (int(int divisor, int dividend))
#   _kernel_sdiv10  (int(int dividend))
#   _kernel_call_client  (int(int a1, int a2, int a3, _kernel_ccproc callee))
#   _kernel_RMAalloc  (void *(size_t size))
#   _kernel_RMAextend  (void *(void *p, size_t size))
#   fseek  (int(FILE *, long int, int))
#   _fseeko  (int(FILE *, _off_t, int))
#   _fseeko64  (int(FILE *, _off64_t, int))
#   ftell  (long int(FILE *))
#   _ftello  (_off_t(FILE *))
#   _ftello64  (_off64_t(FILE *))
#   atol  (long int(const char *))
#   strtol  (long int(const char * restrict, char ** restrict, int))
#   strtoul  (unsigned long int(const char * restrict, char ** restrict, int))
#   atexit  (int(void (* )(void)))
#   at_quick_exit  (int(void (* )(void)))
#   bsearch  (void *(const void *, const void *, size_t, size_t, int (* )(const void *, const void *)))
#   qsort  (void(void *, size_t, size_t, int (* )(const void *, const void *)))
#   labs  (long int(long int))
#   wctomb  (int(char *, wchar_t))
#   fgetws  (wchar_t *(wchar_t * restrict, int n, struct __FILE_struct * restrict))
#   fputwc  (wint_t(wchar_t c, struct __FILE_struct *))
#   putwc  (wint_t(wchar_t, struct __FILE_struct *))
#   putwchar  (wint_t(wchar_t))
#   wcstol  (long int(const wchar_t * restrict, wchar_t ** restrict, int))
#   wcstoul  (unsigned long int(const wchar_t * restrict, wchar_t ** restrict, int))
#   wcschr  (wchar_t *(const wchar_t *, wchar_t))
#   wcsrchr  (wchar_t *(const wchar_t *, wchar_t))
#   wmemchr  (wchar_t *(const wchar_t *, wchar_t, size_t))
#   wmemset  (wchar_t *(wchar_t *, wchar_t, size_t))
#   wcsftime  (size_t(wchar_t * restrict, size_t maxsize, const wchar_t * restrict, const struct tm * restrict))
#   wcrtomb  (size_t(char * restrict, wchar_t, mbstate_t * restrict))
#   iswctype  (int(wint_t, wctype_t))
#   wctype  (wctype_t(const char *))
#   towctrans  (wint_t(wint_t, wctrans_t))
#   wctrans  (wctrans_t(const char *))
#   scandir  (int(const char *, struct dirent ***, int (*)(struct dirent *), int (*)(const void *, const void *)))
#   vwarn  (void(const char *, _BSD_VA_LIST_))
#   vwarnx  (void(const char *, _BSD_VA_LIST_))
#   err_set_exit  (void(void (*)(int)))
#   getifaddrs  (__BEGIN_DECLS extern int(struct ifaddrs **))
#   gethostbyaddr  (struct hostent *(const char *addr, int length, int type))
#   getnetbyaddr  (struct netent *(unsigned long net, int type))
#   getprotobynumber  (struct protoent *(int proto))
#   getservbyport  (struct servent *(int port, const char *proto))
#   htonl  (u_long(u_long x))
#   htons  (int(int x))
#   inet_addr  (u_long(const char *cp))
#   inet_network  (u_long(const char *cp))
#   ntohl  (u_long(u_long x))
#   ntohs  (int(int x))
#   sethostent  (void(int f))
#   setnetent  (void(int f))
#   setprotoent  (void(int f))
#   setservent  (void(int f))
#   sysctlbyname  (int(const char *name, void *oldp, size_t *oldlenp, void *newp, size_t newlen))
#   __dn_skipname  (__BEGIN_DECLS int(const u_char *, const u_char *))
#   __putlong  (void(u_int32_t, u_char *))
#   __putshort  (void(u_int16_t, u_char *))
#   __p_time  (char *(u_int32_t))
#   __p_option  (const char *(u_long option))
#   res_randomid  (u_int16_t())
#   accept  (int(int s, struct sockaddr *addr, int *addrlen))
#   bind  (int(int s, const struct sockaddr *name, int namelen))
#   connect  (int(int s, const struct sockaddr *name, int namelen))
#   getpeername  (int(int s, struct sockaddr *name, int *namelen))
#   getsockname  (int(int s, struct sockaddr *name, int *namelen))
#   getsockopt  (int(int s, int level, int optname, void *optval, int *optlen))
#   listen  (int(int s, int backlog))
#   recv  (int(int s, void *buf, size_t len, int flags))
#   recvfrom  (int(int s, void *buf, size_t len, int flags, struct sockaddr *from, int *fromlenaddr))
#   recvmsg  (int(int s, struct msghdr *msg, int flags))
#   select  (int(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *tv))
#   send  (int(int s, const void *msg, size_t len, int flags))
#   sendmsg  (int(int s, const struct msghdr *msg, int flags))
#   sendto  (int(int s, const void *msg, size_t len, int flags, const struct sockaddr *to, int tolen))
#   setsockopt  (int(int s, int level, int optname, const void *optval, int optlen))
#   shutdown  (int(int s, int how))
#   socketclose  (int(int d))
#   socket  (int(int domain, int type, int protocol))
#   socketstat  (int(int s, struct stat *buf))
#   socketread  (int(int s, void *buf, unsigned int len))
#   socketreadv  (int(int s, const struct iovec *iov, int iovcnt))
#   socketwrite  (int(int s, const void *buf, unsigned int len))
#   socketwritev  (int(int s, const struct iovec *iov, int iovcnt))
#   sysctl  (int(int *name, unsigned int namelen, void *oldp, size_t *oldlenp, void *newp, size_t newlen))
#   naccept  (int(int s, struct nsockaddr *addr, int *addrlen))
#   ngetpeername  (int(int s, struct nsockaddr *name, int *namelen))
#   ngetsockname  (int(int s, struct nsockaddr *name, int *namelen))
#   nrecvfrom  (int(int s, void *buf, size_t len, int flags, struct nsockaddr *from, int *fromlenaddr))
#   nrecvmsg  (int(int s, struct nmsghdr *msg, int flags))
#   nsendmsg  (int(int s, struct nmsghdr *msg, int flags))
#   sendtosm  (int(int s, const void *buf, size_t len, const void *buf1, size_t len1, struct sockaddr_in *to))
#   oaccept  (int(int s, struct osockaddr *addr, int *addrlen))
#   ogetpeername  (int(int s, struct osockaddr *name, int *namelen))
#   ogetsockname  (int(int s, struct osockaddr *name, int *namelen))
#   orecvfrom  (int(int s, void *buf, size_t len, int flags, struct osockaddr *from, int *fromlenaddr))
#   orecvmsg  (int(int s, struct omsghdr *msg, int flags))
#   osendmsg  (int(int s, struct omsghdr *msg, int flags))
#   access  (int(const char *path, int mode))
#   bcmp  (int(const void *s1, const void *s2, unsigned int length))
#   bcopy  (void(const void *src, void *dst, unsigned int length))
#   bzero  (void(void *s, unsigned int length))
#   chmod  (int(const char *path, unsigned short mode))
#   close  (int(int s))
#   err_set_silent  (void(int silent))
#   ffs  (int(int value))
#   fstat  (int(int s, struct stat *buf))
#   getgroups  (int(int ngrps, unsigned long grparray[]))
#   gethostname  (int(char *name, int max_namelen))
#   getopt  (int(int nargc, char *const *nargv, const char *ostr))
#   getpwuid  (struct passwd *(unsigned long uid))
#   index  (char *(const char *s, int c))
#   kvm_open  (kvm_t *(const char *uf, const char *mf, const char *sf, int flag, const char *errout))
#   kvm_openfiles  (kvm_t *(const char *uf, const char *mf, const char *sf, int flag, char *errout))
#   kvm_read  (int(kvm_t *kd, unsigned long kva, void *buf, size_t len))
#   lseek  (long(int d, long offset, int whence))
#   read  (int(int s, void *buf, unsigned int nbytes))
#   readv  (int(int s, const struct iovec *iov, int iovcnt))
#   rindex  (char *(const char *s, int c))
#   sleep  (unsigned int(unsigned int seconds))
#   strncasecmp  (int(const char *a, const char *b, size_t n))
#   write  (int(int s, const void *buf, unsigned int nbytes))
#   writev  (int(int s, const struct iovec *iov, int iovcnt))
#   xputchar  (char(char ch))
#   xstrerror  (char *(int num))
#   getpagesize  (__pure int())
#   setpgrp  (int(pid_t pid, pid_t pgrp))
