<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\ProjectRepository")
 */
class Project
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\OneToMany(targetEntity="App\Entity\Answer", mappedBy="project")
     */
    private $Answers;

    public function __construct()
    {
        $this->Answers = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * @return Collection|Answer[]
     */
    public function getAnswers(): Collection
    {
        return $this->Answers;
    }

    public function addAnswer(Answer $answer): self
    {
        if (!$this->Answers->contains($answer)) {
            $this->Answers[] = $answer;
            $answer->setProject($this);
        }

        return $this;
    }

    public function removeAnswer(Answer $answer): self
    {
        if ($this->Answers->contains($answer)) {
            $this->Answers->removeElement($answer);
            // set the owning side to null (unless already changed)
            if ($answer->getProject() === $this) {
                $answer->setProject(null);
            }
        }

        return $this;
    }
}
