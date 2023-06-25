from pythonjsonlogger import jsonlogger


class JsonFormatter(jsonlogger.JsonFormatter):
    def __init__(self, *args, **kwargs):
        kwargs["reserved_attrs"] = ["color_message", *jsonlogger.RESERVED_ATTRS]
        super().__init__(*args, **kwargs)
