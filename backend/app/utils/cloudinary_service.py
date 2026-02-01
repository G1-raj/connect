import cloudinary.uploader

def upload_image(file, folder: str):
    result = cloudinary.uploader.upload(
        file=file,
        folder=folder,
        resource_type = "image"
    )

    return {
        "image_url": result["secure_url"],
        "public_id": result["public_id"]
    }

def delete_image(public_id: str):
    cloudinary.uploader.destroy(public_id=public_id)
