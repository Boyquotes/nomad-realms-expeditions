extends Node3D
class_name CardPlayerComponent

signal card_exited_hand(card)
signal card_entered_hand(card)
signal card_exited_deck(card)
signal card_entered_deck(card)
signal card_exited_discard(card)
signal card_entered_discard(card)

var hand: Array[WorldCard]
var deck: Array[WorldCard]
var discard: Array[WorldCard]

