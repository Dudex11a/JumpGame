extends Node

const main_tscn := "res://Object/Main/Main.tscn"
const mainmenu_tscn := "res://Object/UI/MainMenu/MainMenu.tscn"
const hat_obj := "res://Object/Actor/Player/Hat/Hat.tscn"
const hat_images := "res://Image/Hats"
const button := "res://Object/UI/DButton/DButton.tscn"
const link_button := "res://Object/UI/DButton/LinkButton/LinkButton.tscn"
const buy_hat_tscn := "res://Object/UI/DButton/BuyHat/BuyHat.tscn"

const audio_tscn := "res://Object/OnLoad/Audio.tscn"
const debug_tscn := "res://Object/OnLoad/Debug/Debug.tscn"

const purchase_popup_tscn: = "res://Object/UI/SmallPopup/PurchasePopup/PurchasePopup.tscn"
const simple_purchase_popup_tscn: = "res://Object/UI/SmallPopup/SimplePurchasePopup/SimplePurchasePopup.tscn"
const text_small_popup_tscn: = "res://Object/UI/SmallPopup/TextSmallPopup/TextSmallPopup.tscn"
const small_popup_tscn: = "res://Object/UI/SmallPopup/SmallPopup.tscn"

const currency_sound := "res://Sound/Currency.wav"
const error_sound := "res://Sound/Error.wav"

const sequences: = "res://Object/DWorld/Sequence/Sequences/"
func make_seq_path(id: String):
	return P.sequences + id + ".tscn"
