function executeExample(type, customTitle = "", customText = "") {
    switch (type) {
        case "success":
            return void Swal.fire({
                icon: "success",
                title: customTitle || "Your work has been saved",
                text: customText || "",
                timer: 1500
            });

        case "error":
            return void Swal.fire({
                icon: "error",
                title: customTitle || "Oops...",
                text: customText || "Something went wrong!"
            });

        case "warning":
            return void Swal.fire({
                icon: "warning",
                title: customTitle || "Oops...",
                text: customText || "Icon warning!"
            });

        case "info":
            return void Swal.fire({
                icon: "info",
                title: customTitle || "Oops...",
                text: customText || "Icon Info!"
            });

        case "question":
            return void Swal.fire({
                icon: "question",
                title: customTitle || "Oops...",
                text: customText || "Icon question!"
            });

        case "warningConfirm":
            return void Swal.fire({
                title: "Are you sure?",
                text: "You won't be able to revert this!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes, delete it!"
            }).then(function (result) {
                if (result.isConfirmed) {
                    Swal.fire("Deleted!", "Your file has been deleted.", "success");
                }
            });

        default:
            return void Swal.fire({
                icon: "info",
                title: "Unknown Action",
                text: "No matching alert type found!"
            });
    }
}
